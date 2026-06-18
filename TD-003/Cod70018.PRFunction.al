codeunit 70018 "AVTD_PR Function"
{
    // version AVTHLC1.0

    // AV AVISION
    // LC Localization
    // //AVAVLC.001
    // -Add the addition code

    Permissions = TableData "Purchase Header" = rm;

    /*var
     Text001: TextConst ENU = 'Document No. %1 Line No. %2 is Over budget in Type %3 Avaiable Budget = %4, Budget is NOT PASS.';
    Text002: Label 'Document No. %1 Check budget must be Blank before Check Budget.';
    PR_AVIN_LineAmt: Decimal;
    PR_AVOut_LineAmt: Decimal;
    PR_AV_LineAmt: Decimal;
    PO_AVIN_LineAmt: Decimal;
    PO_AVOut_LineAmt: Decimal;
    PO_AV_LineAmt: Decimal;
    PR_AVIN_LineQty: Decimal;
    PR_AVOut_LineQty: Decimal;
    PR_AV_LineQty: Decimal;
    PO_AVIN_LineQty: Decimal;
    PO_AVOut_LineQty: Decimal;
    PO_AV_LineQty: Decimal;
    EntryType: Option " ","Check Budget","Un-Check Budget","Commit PO","Un-Commit PO","Cancel PR","Final PO","Cancel PO","Adjust PO","Inv. Deduct PO","Check Budget Issue","Un-Check Budget Issue","Issue Deduct","Issue Actual";
    Reverse_PR: Boolean;
    Reverse_PO: Boolean;
    ReleasePurchDoc: Codeunit "Release Purchase Document";
    "AVPostedInvNo.": Code[20];
    "AVPostedInvLineNo.": Integer;
    AVInv_Inc_VAT: Boolean;
    Text003: TextConst ENU = 'Document No. %1 Line No. %2 is Over Unit Price budget in Type %3 Avaiable Unit Price Budget = %4, Budget is NOT PASS.';
    Text004: TextConst ENU = 'Document No. %1 Line No. %2 is Over Quantity budget in Type %3 Avaiable Quantity Budget = %4, Budget is NOT PASS.';
    AVSumTotalAmt_Per_Document: Decimal;
    CountGLAccount: Integer;
    ALLGLAccount: Integer;
    CheckCriteria: Boolean;
    AVJobTask: Record "Job Task";
    AVPurchLine: Record "Purchase Line";
    Issue_AVIn_LineAmt: Decimal;
    Issue_AVOut_LineAmt: Decimal;
    Issue_AV_LineAmt: Decimal;
    PurchaseH: Record "Purchase Header";
    PurchaseL: Record "Purchase Line";
    PurchH: Record "Purchase Header";
    CheckBudgetPass: Boolean;
    CheckNonBudget: Boolean;
    VatH: Decimal; */

    procedure AutoSplitPRLine(var PurchL: Record "Purchase Line");
    var
        NewPRLine: Record "Purchase Line";
        XPurchL: Record "Purchase Line";
        i: Integer;
        RunningLine: Integer;
    begin
        PurchL.TestField(PurchL."AVTD_Purchase Status", PurchL."AVTD_Purchase Status"::" ");
        PurchL.TestField(PurchL.Type, PurchL.Type::"Fixed Asset");
        PurchL.TestField(PurchL.Quantity);
        if Confirm('Do you want to split PR Line %1 %2 Quantity %3 ?', true, PurchL."Line No.", PurchL.Description, PurchL.Quantity)
        then begin
            Clear(XPurchL);
            XPurchL.COPY(PurchL);
            Clear(RunningLine);
            RunningLine := PurchL."Line No.";
            for i := 1 to PurchL.Quantity do begin
                RunningLine := RunningLine + 10;
                Clear(NewPRLine);
                NewPRLine.Init();
                NewPRLine."Document Type" := PurchL."Document Type";
                NewPRLine."Document No." := PurchL."Document No.";
                NewPRLine."Line No." := RunningLine;
                NewPRLine."Buy-from Vendor No." := PurchL."Buy-from Vendor No.";
                NewPRLine.Validate(Type, PurchL.Type);
                NewPRLine.Description := '-----INSERT Fixed Asset No.';
                NewPRLine.Validate("Location Code", PurchL."Location Code");
                NewPRLine.Validate(Quantity, 1);
                NewPRLine.Validate("Unit of Measure Code", PurchL."Unit of Measure Code");
                NewPRLine.Validate("Direct Unit Cost", PurchL."Direct Unit Cost");
                NewPRLine.Insert();
                NewPRLine.Validate("Gen. Bus. Posting Group", XPurchL."Gen. Bus. Posting Group");
                NewPRLine.Validate("Gen. Prod. Posting Group", XPurchL."Gen. Prod. Posting Group");
                NewPRLine.Validate("VAT Bus. Posting Group", XPurchL."VAT Bus. Posting Group");
                NewPRLine.Validate("VAT Prod. Posting Group", XPurchL."VAT Prod. Posting Group");

                NewPRLine.Validate("Shortcut Dimension 1 Code", XPurchL."Shortcut Dimension 1 Code");
                NewPRLine.Validate("Shortcut Dimension 2 Code", XPurchL."Shortcut Dimension 2 Code");
                NewPRLine.Description := '-----INSERT Fixed Asset No.';
                NewPRLine."Description 2" := '';
                NewPRLine.Modify();
            end;
            PurchL.Validate(PurchL."No.", '');
            PurchL.Description := XPurchL.Description;
            PurchL."Description 2" := XPurchL."Description 2";

            PurchL.Validate("Gen. Bus. Posting Group", XPurchL."Gen. Bus. Posting Group");
            PurchL.Validate("Gen. Prod. Posting Group", XPurchL."Gen. Prod. Posting Group");
            PurchL.Validate("VAT Bus. Posting Group", XPurchL."VAT Bus. Posting Group");
            PurchL.Validate("VAT Prod. Posting Group", XPurchL."VAT Prod. Posting Group");

            PurchL.Validate("Shortcut Dimension 1 Code", XPurchL."Shortcut Dimension 1 Code");
            PurchL.Validate("Shortcut Dimension 2 Code", XPurchL."Shortcut Dimension 2 Code");

            PurchL.Validate("Unit of Measure Code", XPurchL."Unit of Measure Code");
            PurchL.Validate(Quantity, XPurchL.Quantity);
            PurchL.Validate("Direct Unit Cost", XPurchL."Direct Unit Cost");
            PurchL.Modify();
        end;
    end;

    procedure "CANCEL PR"(var AVPurchH: Record "Purchase Header");
    var
        AVPurchL: Record "Purchase Line";
    begin
        if Confirm('Do you want to cancel PR No. %1 ?', true, AVPurchH."No.") then begin
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
            AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
            AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
            if AVPurchL.Find('-') then
                repeat
                    AVPurchL."AVTD_Purchase Status" := AVPurchL."AVTD_Purchase Status"::Cancel;
                    AVPurchL.Modify();
                until AVPurchL.Next() = 0;

            AVPurchH."AVTD_Purchase Status" := AVPurchH."AVTD_Purchase Status"::Cancel;
            //AVPurchH.FINISHED := AVPurchH.FINISHED::FINISHED;
            AVPurchH.AVTD_FINISHED := true;
            AVPurchH.Modify();
        end;
    end;

    procedure "CANCEL PO"(var AVPurchH: Record "Purchase Header");
    var
        AVPurchL: Record "Purchase Line";
    begin
        if Confirm('Do you want to cancel PO No. %1 ?', true, AVPurchH."No.") then begin
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
            AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
            AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
            if AVPurchL.Find('-') then
                repeat
                    if AVPurchL."Quantity Received" <> 0 then
                        Error('PO %1 Line No. %2 Type %3 No. %4 already received. Cannot CANCEL PO, please use FINAL PO',
                              AVPurchL."Document No.", AVPurchL."Line No.", AVPurchL.Type, AVPurchL."No.");

                    AVPurchL."AVTD_Purchase Status" := AVPurchL."AVTD_Purchase Status"::Cancel;

                    AVPurchL.Validate("Qty. to Receive", 0);
                    AVPurchL."Qty. to Receive (Base)" := 0;

                    AVPurchL."Outstanding Quantity" := 0;
                    AVPurchL."Outstanding Qty. (Base)" := 0;
                    AVPurchL."Qty. Rcd. Not Invoiced" := 0;

                    AVPurchL."Outstanding Amount" := 0;
                    AVPurchL."Outstanding Amount (LCY)" := 0;

                    AVPurchL.Validate("Qty. to Invoice", 0);
                    AVPurchL."Qty. to Invoice (Base)" := 0;
                    //AVAVLC.001
                    AVPurchL."Outstanding Amt. Ex. VAT (LCY)" := 0;
                    //C-AVAVLC.001
                    AVPurchL.Modify();
                until AVPurchL.Next() = 0;

            AVPurchH."AVTD_Purchase Status" := AVPurchH."AVTD_Purchase Status"::Cancel;
            //AVPurchH.FINISHED := AVPurchH.FINISHED::FINISHED;
            AVPurchH.AVTD_FINISHED := true;
            AVPurchH.Modify();
        end;
    end;

    procedure "FINAL PO"(var AVPurchH: Record "Purchase Header");
    var
        AVPurchL: Record "Purchase Line";
        QtyRecNotInv: Decimal;
    begin
        if Confirm('Do you want to final PO No. %1 ?', true, AVPurchH."No.") then begin
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
            AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
            AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
            AVPurchL.SetFilter(AVPurchL."Quantity Received", '<>%1', 0);
            if not AVPurchL.FindFirst() then
                Error('PO No. %1 is not received. Cannot FINAL PO, please use CANCEL PO', AVPurchH."No.");

            Clear(QtyRecNotInv);
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
            AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
            AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
            if AVPurchL.Find('-') then
                repeat
                    if AVPurchL."Quantity Received" <> AVPurchL."Quantity Invoiced" then
                        Error('PO %1 Line No. %2 Type %3 No. %4 not invoiced. Cannot use FINAL PO',
                              AVPurchL."Document No.", AVPurchL."Line No.", AVPurchL.Type, AVPurchL."No.");

                    QtyRecNotInv += AVPurchL."Qty. Rcd. Not Invoiced";

                    AVPurchL."AVTD_Purchase Status" := AVPurchL."AVTD_Purchase Status"::"Final PO";

                    AVPurchL.Validate("Qty. to Receive", 0);
                    AVPurchL."Qty. to Receive (Base)" := 0;

                    AVPurchL."Outstanding Quantity" := 0;
                    AVPurchL."Outstanding Qty. (Base)" := 0;
                    AVPurchL."Qty. Rcd. Not Invoiced" := 0;

                    AVPurchL."Outstanding Amount" := 0;
                    AVPurchL."Outstanding Amount (LCY)" := 0;

                    AVPurchL.Validate("Qty. to Invoice", 0);
                    AVPurchL."Qty. to Invoice (Base)" := 0;
                    //AVNP_Fixed_LC.001
                    AVPurchL."Outstanding Amt. Ex. VAT (LCY)" := 0;
                    //C-AVNP_Fixed_LC.001

                    AVPurchL.Modify();
                until AVPurchL.Next() = 0;

            AVPurchH."AVTD_Purchase Status" := AVPurchH."AVTD_Purchase Status"::"Final PO";
            //AVPurchH.FINISHED := AVPurchH.FINISHED::FINISHED;
            AVPurchH.AVTD_FINISHED := true;
            AVPurchH.Modify();
        end;
    end;

    procedure "FINISH PR"(var AVPurchH: Record "Purchase Header");
    var
        AVPurchL: Record "Purchase Line";
        QtyRecNotInv: Decimal;
    begin
        if Confirm('Do you want to finish PR No. %1 ?', true, AVPurchH."No.") then begin
            Clear(QtyRecNotInv);
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey(AVPurchL."Document Type", AVPurchL."Document No.");
            AVPurchL.SetRange(AVPurchL."Document No.", AVPurchH."No.");
            AVPurchL.SetRange(AVPurchL."Document Type", AVPurchH."Document Type");
            if AVPurchL.FindSet(true) then
                repeat
                    QtyRecNotInv += AVPurchL."Qty. Rcd. Not Invoiced";

                    AVPurchL."AVTD_Purchase Status" := AVPurchL."AVTD_Purchase Status"::"Final PO";

                    AVPurchL.Validate("Qty. to Receive", 0);
                    AVPurchL."Qty. to Receive (Base)" := 0;

                    AVPurchL."Outstanding Quantity" := 0;
                    AVPurchL."Outstanding Qty. (Base)" := 0;
                    AVPurchL."Qty. Rcd. Not Invoiced" := 0;

                    AVPurchL."Outstanding Amount" := 0;
                    AVPurchL."Outstanding Amount (LCY)" := 0;

                    AVPurchL.Validate("Qty. to Invoice", 0);
                    AVPurchL."Qty. to Invoice (Base)" := 0;

                    AVPurchL.Modify();
                until AVPurchL.Next() = 0;

            //AVPurchH.FINISHED := AVPurchH.FINISHED::FINISHED;
            AVPurchH.AVTD_FINISHED := true;
            AVPurchH.Modify();
        end;
    end;
}

