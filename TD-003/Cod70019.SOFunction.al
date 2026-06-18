codeunit 70019 "AVTD_SO Function"
{
    // version AVTHLC1.0
    var
        /* Window: Dialog;
        SalesHead: Record "Sales Header"; */
        //ItemUnitOfMeasure: Record "Item Unit of Measure";
        SalesLine: Record "Sales Line";
        GeneralSetup: Record "General Ledger Setup";
        Text001Err: Label 'SO %1 Line No. %2 Type %3 No. %4 not invoiced. Cannot use Finish SO.';
        Text002Err: Label 'SO %1 Line No. %2 Type %3 No. %4 already shipped. Cannot use CANCEL SO.';

    procedure FinishSO(SalesH: Record "Sales Header");
    begin
        //AVTSTSTD.003 16/08/2012
        //Create function FinishSO (move code from report)
        //with SalesH do
        if Confirm('Do you want to confirm finish SO No. %1 ?', true, SalesH."No.") then begin
            Clear(SalesLine);
            SalesLine.SetCurrentKey("Document Type", "Document No.");
            SalesLine.SetRange(SalesLine."Document No.", SalesH."No.");
            SalesLine.SetRange(SalesLine."Document Type", SalesH."Document Type");
            SalesLine.SetFilter(SalesLine."Quantity Shipped", '<>%1', 0);
            if not SalesLine.FindFirst() then
                Error('SO No. %1 is not Shipped. Cannot FINISHED SO, Please use CANCEL SO.',
                         SalesH."No.");

            Clear(SalesLine);
            SalesLine.SetCurrentKey(SalesLine."Document Type", SalesLine."Document No.");
            SalesLine.SetRange("Document No.", SalesH."No.");
            SalesLine.SetRange("Document Type", SalesH."Document Type");
            SalesLine.SetFilter("Outstanding Quantity", '<>%1', 0);
            if SalesLine.Find('-') then
                repeat
                    if SalesLine."Quantity Shipped" = SalesLine."Quantity Invoiced" then begin
                        SalesLine.AVTD_AVCancel := true;

                        SalesLine.VALIDATE("Qty. to Ship", 0);
                        SalesLine."Qty. to Ship (Base)" := 0;

                        SalesLine."Outstanding Quantity" := 0;
                        SalesLine."Outstanding Qty. (Base)" := 0;
                        SalesLine."Qty. Shipped Not Invoiced" := 0;

                        SalesLine."Outstanding Amount" := 0;
                        SalesLine."Outstanding Amount (LCY)" := 0;

                        SalesLine.VALIDATE("Qty. to Invoice", 0);
                        SalesLine."Qty. to Invoice (Base)" := 0;

                        SalesLine.Modify();
                    end else
                        Error(Text001Err, SalesLine."Document No.", SalesLine."Line No.", SalesLine.Type, SalesLine."No.");
                //commment because we not use sub document type sales local or sales export   
                /* if "Sub Document Type" = "Sub Document Type"::"Sale Local" then begin
                    // Sales Local
                    if SalesLine."Quantity Shipped" = SalesLine."Quantity Invoiced" then begin
                        SalesLine.FNGN011_AVCancel := true;

                        SalesLine.VALIDATE("Qty. to Ship", 0);
                        SalesLine."Qty. to Ship (Base)" := 0;

                        SalesLine."Outstanding Quantity" := 0;
                        SalesLine."Outstanding Qty. (Base)" := 0;
                        SalesLine."Qty. Shipped Not Invoiced" := 0;

                        SalesLine."Outstanding Amount" := 0;
                        SalesLine."Outstanding Amount (LCY)" := 0;

                        SalesLine.VALIDATE("Qty. to Invoice", 0);
                        SalesLine."Qty. to Invoice (Base)" := 0;

                        SalesLine.Modify();
                    end else
                        Error(Text001, SalesLine."Document No.", SalesLine."Line No.", SalesLine.Type, SalesLine."No.");
                end else
                    if "Sub Document Type" = "Sub Document Type"::"Sale Export" then begin
                        // Sales Export
                        if SalesLine."Quantity Shipped" = SalesLine."Quantity Invoiced" then begin
                            SalesLine.FNGN011_AVCancel := true;

                            SalesLine.VALIDATE("Qty. to Ship", 0);
                            SalesLine."Qty. to Ship (Base)" := 0;

                            SalesLine."Outstanding Quantity" := 0;
                            SalesLine."Outstanding Qty. (Base)" := 0;
                            SalesLine."Qty. Shipped Not Invoiced" := 0;

                            SalesLine."Outstanding Amount" := 0;
                            SalesLine."Outstanding Amount (LCY)" := 0;

                            SalesLine.VALIDATE("Qty. to Invoice", 0);
                            SalesLine."Qty. to Invoice (Base)" := 0;

                            SalesLine.Modify();
                        end else
                            Error(Text001, SalesLine."Document No.", SalesLine."Line No.", SalesLine.Type, SalesLine."No.");
                    end; */
                until SalesLine.Next() = 0;
            //FINISHED := FINISHED::FINISHED;
            SalesH."AVTD_Sales Status" := SalesH."AVTD_Sales Status"::"Final SO";
            SalesH.AVTD_FINISHED := true;
            SalesH.Modify();
        end;
        //End - AVTSTSTD.003 16/08/2012
    end;

    procedure UnfinishSO(SalesH: Record "Sales Header");
    begin
        //AVNCCSTD.001 20.06.2012
        //Create function UnfinishSO
        if Confirm('Do you want to confirm undo finished SO No. %1 ?', true, SalesH."No.") then begin
            GeneralSetup.Get();
            Clear(SalesLine);
            SalesLine.SetCurrentKey(SalesLine."Document Type", SalesLine."Document No.");
            SalesLine.SetRange(SalesLine."Document No.", SalesH."No.");
            SalesLine.SetRange(SalesLine."Document Type", SalesH."Document Type");
            if SalesLine.FindSet(true) then
                repeat
                    SalesLine.AVTD_AVCancel := false;

                    //AVTSTSTD.002 12/07/2012
                    //Add code for call function InitOutstandingAmount on function UnfinishSO
                    /*
                    SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
                    SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
                    SalesLine.VALIDATE("Qty. to Ship",SalesLine.Quantity - SalesLine."Quantity Shipped");
                    SalesLine.VALIDATE("Qty. to Invoice",SalesLine.Quantity - SalesLine."Quantity Invoiced");
                    SalesLine."Outstanding Amount" := ROUND((SalesLine."Unit Price" + (SalesLine."Unit Price" * (SalesLine."VAT %"/100)))
                                           * SalesLine."Outstanding Quantity",GeneralSetup."Amount Rounding Precision");
                    IF SalesH."Currency Factor" <> 0 THEN
                      SalesLine."Outstanding Amount (LCY)" := ROUND(SalesLine."Outstanding Amount"/SalesH."Currency Factor",
                                                              GeneralSetup."Amount Rounding Precision")
                    ELSE
                      SalesLine."Outstanding Amount (LCY)" := SalesLine."Outstanding Amount";
                    */

                    SalesLine."Qty. to Ship" := SalesLine.Quantity - SalesLine."Quantity Shipped";
                    SalesLine."Qty. to Ship (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
                    SalesLine."Qty. to Invoice" := SalesLine.Quantity - SalesLine."Quantity Invoiced";
                    SalesLine."Qty. to Invoice (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Invoiced (Base)";
                    SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
                    SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
                    SalesLine.InitOutstandingAmount();
                    //End - AVTSTSTD.002 12/07/2012

                    SalesLine.Modify();
                until SalesLine.Next() = 0;

            //SalesH.FINISHED := SalesH.FINISHED::" ";
            SalesH.AVTD_FINISHED := false;
            SalesH."AVTD_Sales Status" := SalesH."AVTD_Sales Status"::" ";
            SalesH.Modify();
        end;
        //E-AVNCCSTD.001 20.06.2012

    end;

    procedure CancelSO(SalesH: Record "Sales Header");
    begin
        //AVTSTSTD.004 16/08/2012
        //Create function CancelSO (move code from report)
        //with SalesH do
        if Confirm('Do you want to confirm cancel SO No. %1 ?', true, SalesH."No.") then begin
            Clear(SalesLine);
            SalesLine.SetCurrentKey("Document Type", "Document No.");
            SalesLine.SetRange(SalesLine."Document No.", SalesH."No.");
            SalesLine.SetRange(SalesLine."Document Type", SalesH."Document Type");
            SalesLine.SetFilter(SalesLine."Quantity Shipped", '<>%1', 0);
            if SalesLine.FindFirst() then
                Error('SO %1 Line No. %2 Type %3 No. %4 already received. Cannot CANCEL SO, Please use FINISHED SO.',
                         SalesLine."Document No.", SalesLine."Line No.", SalesLine.Type, SalesLine."No.");

            CLEAR(SalesLine);
            SalesLine.SetCurrentKey(SalesLine."Document Type", SalesLine."Document No.");
            SalesLine.SetRange(SalesLine."Document No.", SalesH."No.");
            SalesLine.SetRange(SalesLine."Document Type", SalesH."Document Type");
            if SalesLine.FindSet(true) then
                repeat
                    if SalesLine."Quantity Shipped" <> 0 then
                        Error(Text002Err, SalesLine."Document No.", SalesLine."Line No.", SalesLine.Type, SalesLine."No.");

                    SalesLine.Validate("Qty. to Ship", 0);
                    SalesLine."Qty. to Ship (Base)" := 0;

                    SalesLine."Outstanding Quantity" := 0;
                    SalesLine."Outstanding Qty. (Base)" := 0;
                    SalesLine."Qty. Shipped Not Invoiced" := 0;

                    SalesLine."Outstanding Amount" := 0;
                    SalesLine."Outstanding Amount (LCY)" := 0;

                    SalesLine.Validate("Qty. to Invoice", 0);
                    SalesLine."Qty. to Invoice (Base)" := 0;

                    SalesLine.Modify();
                until SalesLine.Next() = 0;
            //Cancel := true;
            SalesH."AVTD_Sales Status" := SalesH."AVTD_Sales Status"::Cancel;
            SalesH.AVTD_FINISHED := true;
            SalesH.Modify();
        end;
        //End - AVTSTSTD.004 16/08/2012
    end;
}

