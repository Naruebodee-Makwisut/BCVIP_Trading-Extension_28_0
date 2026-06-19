codeunit 70020 "AVTD_COD241"
{
    EventSubscriberInstance = StaticAutomatic;

    local procedure BeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        //with ItemJournalLine do begin
        Clear(ItemJnlBatch);
        if ItemJnlBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name") then
            if ItemJnlBatch."AVTD_Journal Type" = ItemJnlBatch."AVTD_Journal Type"::Issue then
                HideDialog := true;
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnBeforeCode', '', true, true)]
    local procedure OnBeforeCode(var ItemJournalLine: Record "Item Journal Line"; var HideDialog: Boolean; var SuppressCommit: Boolean; var IsHandled: Boolean)
    begin
        BeforeCode(ItemJournalLine, HideDialog, SuppressCommit, IsHandled);
    end;
}