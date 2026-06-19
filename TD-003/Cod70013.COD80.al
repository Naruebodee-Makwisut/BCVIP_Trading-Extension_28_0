codeunit 70013 "AVTD_COD80"
{
    EventSubscriberInstance = StaticAutomatic;
    local procedure AfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        AVSaleL: Record "Sales Line";
        AVRemainingQty: Decimal;
    begin
        //with SalesHeader do
        //AVTSTSTD.011 01/07/2012 (11/10/2012)
        //Add code for finish document when fully Post Ship on trigger OnRun
        if SalesHeader.Ship and (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
            //Post fully shipment
            Clear(AVRemainingQty);
            Clear(AVSaleL);
            AVSaleL.SetCurrentKey("Document Type", "Document No.");
            AVSaleL.SetRange("Document Type", SalesHeader."Document Type");
            AVSaleL.SetRange("Document No.", SalesHeader."No.");
            if AVSaleL.Find('-') then begin
                repeat
                    AVRemainingQty := AVRemainingQty + (AVSaleL.Quantity - AVSaleL."Quantity Shipped");
                until AVSaleL.Next() = 0;

                if AVRemainingQty = 0 then begin
                    SalesHeader.AVTD_FINISHED := true;
                    SalesHeader."AVTD_Sales Status" := SalesHeader."AVTD_Sales Status"::Fully;
                    SalesHeader.Modify();
                end;
            end;
        end;
        //End - AVTSTSTD.011 01/07/2012 (11/10/2012)
        /* AVSaleL.SETCURRENTKEY("Document Type","Document No.");
  AVSaleL.SETRANGE("Document Type","Document Type");
  AVSaleL.SETRANGE("Document No.","No."); */
        /*  Clear(SalesLine);
         SalesLine.SetCurrentKey("Document Type", "Document No.");
         SalesLine.SetRange("Document Type", "Document Type");
         SalesLine.SetRange("Document No.", "No.");
         if SalesLine.Find('-') then begin
             repeat */
        /* 
            //AVTSTSTD.008 01/07/2012
            //Add code for update value in Sales Order Line Local in case Post All Invoice on function OnRun
            AVSaleL."Quantity Shipped" += AVSaleL."Qty. to Ship";
            AVSaleL."Qty. Shipped (Base)" += AVSaleL."Qty. to Ship (Base)";
            AVSaleL."Quantity Invoiced" += AVSaleL."Qty. to Invoice";
            AVSaleL."Qty. Invoiced (Base)" += AVSaleL."Qty. to Invoice (Base)";
            AVSaleL.InitQtyToShip;
            AVSaleL.InitQtyToInvoice;
            AVSaleL.InitOutstanding;
            //AVNPSTD.001 06.03.2018
            IF AVSaleL."Outstanding Qty. (Base)" <> 0 THEN
                AVSaleL.VALIDATE("Qty. to Ship", (AVSaleL.Quantity - AVSaleL."Quantity Shipped"))
            ELSE
                AVSaleL."Qty. to Ship" := (AVSaleL.Quantity - AVSaleL."Quantity Shipped");
            //C-AVNPSTD.001
            //AVSaleL.VALIDATE("Qty. to Ship",(AVSaleL.Quantity - AVSaleL."Quantity Shipped"));
            AVSaleL.VALIDATE("Qty. to Invoice", (AVSaleL.Quantity - AVSaleL."Quantity Invoiced"));
            AVSaleL.MODIFY;
            //End - AVTSTSTD.008 01/07/2012

            AVRemainingQty := AVRemainingQty + (AVSaleL.Quantity - AVSaleL."Quantity Invoiced"); */
        /* Salesline."Qty. to Ship" := 0;
        salesline."Qty. to Ship (Base)" := 0;
        Salesline."Quantity Shipped" := 0;
        SalesLine."Qty. Shipped (Base)" := 0;
        SalesLine."Qty. to Invoice" := 0;
        SalesLine."Qty. to Invoice (Base)" := 0;
        SalesLine."Quantity Invoiced" := 0;
        SalesLine."Qty. Invoiced (Base)" := 0;
        SalesLine."Outstanding Quantity" := 0;
        SalesLine."Outstanding Amount" := 0;
        SalesLine."Outstanding Amount (LCY)" := 0;
        salesline."Outstanding Qty. (Base)" := 0;
    until SalesLine.Next() = 0;
end; */

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', true, true)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        AfterFinalizePostingOnBeforeCommit(SalesHeader, SalesShipmentHeader, SalesInvoiceHeader, SalesCrMemoHeader, ReturnReceiptHeader, GenJnlPostLine, CommitIsSuppressed, PreviewMode);
    end;

    local procedure BeforeDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean; CommitIsSuppressed: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        //with SalesHeader do
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SkipDelete := true;
            Clear(SalesLine);
            SalesLine.SetCurrentKey("Document Type", "Document No.");
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.Find('-') then
                repeat
                    /*  Salesline."Qty. to Ship" := 0;
                     salesline."Qty. to Ship (Base)" := 0;
                     Salesline."Quantity Shipped" := 0;
                     SalesLine."Qty. Shipped (Base)" := 0;
                     SalesLine."Qty. to Invoice" := 0;
                     SalesLine."Qty. to Invoice (Base)" := 0;
                     SalesLine."Quantity Invoiced" := 0;
                     SalesLine."Qty. Invoiced (Base)" := 0;
                     SalesLine."Outstanding Quantity" := 0;
                     SalesLine."Outstanding Amount" := 0;
                     SalesLine."Outstanding Amount (LCY)" := 0;
                     salesline."Outstanding Qty. (Base)" := 0;
                     salesline.Modify(); */

                    //AVTSTSTD.008 01/07/2012
                    //Add code for update value in Sales Order Line Local in case Post All Invoice on function OnRun
                    SalesLine."Quantity Shipped" += SalesLine."Qty. to Ship";
                    SalesLine."Qty. Shipped (Base)" += SalesLine."Qty. to Ship (Base)";
                    SalesLine."Quantity Invoiced" += SalesLine."Qty. to Invoice";
                    SalesLine."Qty. Invoiced (Base)" += SalesLine."Qty. to Invoice (Base)";
                    SalesLine.InitQtyToShip();
                    SalesLine.InitQtyToInvoice();
                    SalesLine.InitOutstanding();
                    //AVNPSTD.001 06.03.2018
                    if SalesLine."Outstanding Qty. (Base)" <> 0 then
                        SalesLine.VALIDATE("Qty. to Ship", (SalesLine.Quantity - SalesLine."Quantity Shipped"))
                    else
                        SalesLine."Qty. to Ship" := (SalesLine.Quantity - SalesLine."Quantity Shipped");
                    //C-AVNPSTD.001
                    //AVSaleL.VALIDATE("Qty. to Ship",(AVSaleL.Quantity - AVSaleL."Quantity Shipped"));
                    SalesLine.Validate("Qty. to Invoice", (SalesLine.Quantity - SalesLine."Quantity Invoiced"));
                    SalesLine.Modify();
                //End - AVTSTSTD.008 01/07/2012
                until SalesLine.Next() = 0;
            SalesHeader.AVTD_FINISHED := true;
            SalesHeader."AVTD_Sales Status" := SalesHeader."AVTD_Sales Status"::Fully;
            SalesHeader.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', true, true)]
    local procedure OnBeforeDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean; CommitIsSuppressed: Boolean)
    begin
        BeforeDeleteAfterPosting(SalesHeader, SalesInvoiceHeader, SalesCrMemoHeader, SkipDelete, CommitIsSuppressed);
    end;
}