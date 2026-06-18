codeunit 70015 "AVTD_COD22"
{
    EventSubscriberInstance = StaticAutomatic;
    local procedure AfterInitItemLedgEntry(VAR NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer)
    begin
        //with NewItemLedgEntry do
        NewItemLedgEntry."AVTD_Create Date" := CurrentDateTime();

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure OnAfterInitItemLedgEntry(VAR NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; VAR ItemLedgEntryNo: Integer)
    begin
        AfterInitItemLedgEntry(NewItemLedgEntry, ItemJournalLine, ItemLedgEntryNo);
    end;
    //TD-005
    local procedure BeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    var
        AVItemLedger: Record "Item Ledger Entry";
        rItem: Record Item;
        AVQty: Decimal;
        Text00555Err: Label 'Negative Inventory is not allowed.\Please check Document No. %1 Line No. %2 Item No. %3 Location %4';
        IsHandle: Boolean;
    begin
        OnBeforeCheckItemJnlPost(ItemJournalLine, IsHandle);
        if IsHandle then
            exit;
        //with ItemJournalLine do begin
        if rItem.GET(ItemJournalLine."Item No.") then;
        if (rItem.PreventNegativeInventory()) and (ItemJournalLine."Item Charge No." = '') then
            if (ItemJournalLine.Adjustment = false) and (ItemJournalLine."Source Code" <> 'INVTADJMT') then
                if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.") or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.")
                or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Purchase) or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer)
                or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale) or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Assembly Consumption")
                or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption) then begin
                    Clear(AVQty);
                    Clear(AVItemLedger);
                    //AVItemLedger.SetCurrentKey(AVItemLedger."Entry No.");
                    AVItemLedger.SetCurrentKey("Item No.", Positive, "Location Code", "Variant Code");
                    AVItemLedger.SetRange(AVItemLedger."Item No.", ItemJournalLine."Item No.");
                    AVItemLedger.SetRange(AVItemLedger."Location Code", ItemJournalLine."Location Code");
                    AVItemLedger.SetFilter(AVItemLedger.Quantity, '<>%1', 0);
                    AVItemLedger.SetLoadFields("Posting Date", "Remaining Quantity");
                    if AVItemLedger.FindSet() then
                        repeat
                            if (AVItemLedger."Posting Date" <= ItemJournalLine."Posting Date") then
                                //AVNVKSTD 12/07/13  from CST
                                //AVQty := AVQty + (AVItemLedger."Remaining Quantity" * AVItemLedger."Qty. per Unit of Measure");
                                AVQty := AVQty + (AVItemLedger."Remaining Quantity");
                        //C-AVNVKSTD 12/07/13
                        until AVItemLedger.Next() = 0;
                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." then
                        if (ItemJournalLine."Quantity (Base)" > 0) and (ItemJournalLine."Quantity (Base)" > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt." then
                        if (ItemJournalLine."Quantity (Base)" < 0) and (ABS(ItemJournalLine."Quantity (Base)") > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Purchase then
                        if (ItemJournalLine."Quantity (Base)" < 0) and (ABS(ItemJournalLine."Quantity (Base)") > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale) and (ItemJournalLine."Applies-to Entry" = 0) then //AVNVKSTD
                        if (ItemJournalLine."Quantity (Base)" > 0) and (ABS(ItemJournalLine."Quantity (Base)") > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption then
                        if (ItemJournalLine."Quantity (Base)" > 0) and (ItemJournalLine."Quantity (Base)" > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer then
                        if (ItemJournalLine."Quantity (Base)" > 0) and (ItemJournalLine."Quantity (Base)" > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");

                    if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Assembly Consumption" then
                        if (ItemJournalLine."Quantity (Base)" > 0) and (ItemJournalLine."Quantity (Base)" > AVQty) then
                            Error(Text00555Err, ItemJournalLine."Item No.", ItemJournalLine."Line No.", ItemJournalLine."Item No."
                                  , ItemJournalLine."Location Code");
                end;
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforePostItemJnlLine', '', true, true)]
    local procedure OnBeforePostItemJnlLine(var ItemJournalLine: Record "Item Journal Line")
    begin
        //BeforePostItemJnlLine(ItemJournalLine);
    end;
    //C-TD-005

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckItemJnlPost(var ItemJnlLine: Record "Item Journal Line"; var IsHandle: Boolean)
    begin
    end;
}