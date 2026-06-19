codeunit 70014 "AVTD_COD90"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', true, true)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var PurchHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        PurchaseLTB: Record "Purchase Line";
        Line: Integer;
        AVReceiptCompleteLine: Integer;
    begin
        //with PurchHeader do begin
        //AVTSTSTD.002 01/07/2012
        //Add Code For If Complete Post Receipt then FINISHED = FINISHED
        //Apply from AVWIEPK.008 09.03.2011
        Clear(Line);
        Clear(AVReceiptCompleteLine);
        Clear(PurchaseLTB);
        PurchaseLTB.SetCurrentKey("Document Type", "Document No.");
        PurchaseLTB.SetRange("Document No.", PurchHeader."No.");
        PurchaseLTB.SetRange("Document Type", PurchHeader."Document Type");
        PurchaseLTB.SetFilter("No.", '<>%1', '');
        PurchaseLTB.SetFilter(Quantity, '>%1', 0);
        if PurchaseLTB.find('-') then
            repeat
                Line := Line + 1;
                if PurchaseLTB.Quantity = PurchaseLTB."Quantity Received" then
                    AVReceiptCompleteLine := AVReceiptCompleteLine + 1;
            until PurchaseLTB.Next() = 0;

        if (AVReceiptCompleteLine = Line) and (Line <> 0) then begin
            PurchHeader.AVTD_FINISHED := true;
            PurchHeader."AVTD_Purchase Status" := PurchHeader."AVTD_Purchase Status"::Fully;
            PurchHeader.Modify();

            Clear(PurchaseLTB);
            PurchaseLTB.SetCurrentKey(PurchaseLTB."Document Type", PurchaseLTB."Document No.");
            PurchaseLTB.SetRange("Document No.", PurchHeader."No.");
            PurchaseLTB.SetRange("Document Type", PurchHeader."Document Type");
            if PurchaseLTB.FindSet() then
                PurchaseLTB.ModifyAll(PurchaseLTB."AVTD_Purchase Status", PurchaseLTB."AVTD_Purchase Status"::Fully);
        end;
        //End - AVTSTSTD.002 01/07/2012
        //end;
    end;

    local procedure BeforeDeleteAfterPosting(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var SkipDelete: Boolean; CommitIsSupressed: Boolean)
    var
        PurchLine: Record "Purchase Line";
        Line: Integer;
        RcptCompleteLine: Integer;
    begin
        //with PurchaseHeader do
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            SkipDelete := true;

            Clear(PurchLine);
            PurchLine.SetCurrentKey("Document Type", "Document No.");
            PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetFilter("No.", '<>%1', '');
            PurchLine.SetFilter(Quantity, '>%1', 0);
            if PurchLine.FindSet(true) then begin
                Clear(Line);
                Clear(RcptCompleteLine);
                repeat
                    Line += 1;
                    //check line already full receive
                    //Message(Format(PurchLine."Qty. to Receive") + '-' + Format(PurchLine."Quantity Received"));
                    //if (PurchLine."Qty. to Receive" + PurchLine."Quantity Received") = PurchLine.Quantity then begin
                    PurchLine."Quantity Received" := PurchLine."Quantity Received" + purchline."Qty. to Receive";
                    PurchLine."Qty. Received (Base)" := PurchLine."Qty. Received (Base)" + PurchLine."Qty. to Receive (Base)";
                    PurchLine."Quantity Invoiced" := PurchLine."Quantity Invoiced" + PurchLine."Qty. to Invoice";
                    PurchLine."Qty. Invoiced (Base)" := PurchLine."Qty. Invoiced (Base)" + purchline."Qty. to Invoice (Base)";

                    /* PurchLine."Qty. to Invoice" := 0;
                    PurchLine."Qty. to Invoice (Base)" := 0;
                    PurchLine."Qty. to Receive" := 0;
                    PurchLine."Qty. to Receive (Base)" := 0; */

                    PurchLine."Outstanding Quantity" := 0;
                    PurchLine."Outstanding Qty. (Base)" := 0;
                    PurchLine."Outstanding Amount" := 0;
                    PurchLine."Outstanding Amount (LCY)" := 0;
                    PurchLine."Outstanding Amt. Ex. VAT (LCY)" := 0;

                    PurchLine."Qty. to Receive" := (PurchLine.Quantity - PurchLine."Quantity Received");
                    PurchLine.Validate("Qty. to Invoice", (PurchLine.Quantity - PurchLine."Quantity Invoiced"));
                    RcptCompleteLine += 1;
                    PurchLine.Modify();
                //end;
                until PurchLine.Next() = 0;
            end;
            //if (RcptCompleteLine = Line) and (Line <> 0) then begin
            PurchaseHeader.AVTD_FINISHED := true;
            PurchaseHeader."AVTD_Purchase Status" := PurchaseHeader."AVTD_Purchase Status"::Fully;
            PurchaseHeader.Modify();
            //end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeDeleteAfterPosting', '', true, true)]
    local procedure OnBeforeDeleteAfterPosting(var PurchaseHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var SkipDelete: Boolean; CommitIsSupressed: Boolean)
    begin
        BeforeDeleteAfterPosting(PurchaseHeader, PurchInvHeader, PurchCrMemoHdr, SkipDelete, CommitIsSupressed);
    end;
}