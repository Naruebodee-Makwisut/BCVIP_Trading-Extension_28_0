codeunit 70017 "AVTD_TAB83"
{
    EventSubscriberInstance = StaticAutomatic;
    local procedure AfterValidateItemNoEvent(var ItemJnlLine: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    var
        IssueH: Record "AVTD_Issue Header";
    begin
        //with ItemJnlLine do begin
        //AVNVKSTD.001 02/05/13
        //Add code for Keep Dim form Issue Header
        Clear(IssueH);
        if IssueH.GET(ItemJnlLine."Document No.") then begin
            ItemJnlLine.Validate("Salespers./Purch. Code", IssueH."Requested By");
            ItemJnlLine.Validate("AVTD_Customer Code", IssueH."Customer No.");
            ItemJnlLine."Posting Date" := IssueH."Posting Date";
            ItemJnlLine.Validate("Gen. Bus. Posting Group", IssueH."Gen. Bus Posting Group");
            ItemJnlLine.Validate("Shortcut Dimension 1 Code", IssueH."Shortcut Dimension 1 Code");
            ItemJnlLine.Validate("Shortcut Dimension 2 Code", IssueH."Shortcut Dimension 2 Code");

            //AVPTHSTD //VIP3
            //GLSetup.GET;
            //InsertUpdateJnlLineDimension('ITEMS',"Line No.","Item No.");
            //InsertUpdateJnlLineDimension(GLSetup."Global Dimension 1 Code","Line No.",IssueH."Shortcut Dimension 1 Code");
            //InsertUpdateJnlLineDimension('SALESPERSON',"Line No.",IssueH."Requested By");
            //C-AVPTHSTD //VIP3

        end;
        //C-AVNVKSTD.001 02/05/13
        //end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Item No.', true, true)]
    local procedure OnAfterValidateItemNoEvent(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line"; CurrFieldNo: Integer)
    begin
        AfterValidateItemNoEvent(Rec, xRec, CurrFieldNo);
    end;
}