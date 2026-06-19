codeunit 70016 "AVTD_TAB39"
{
    EventSubscriberInstance = StaticAutomatic;

    local procedure AfterDeletePurchLineEvent(var PurchLine: Record "Purchase Line"; RunTrigger: Boolean)
    var
        AVPurchLine: Record "Purchase Line";
    begin
        if not PurchLine.IsTemporary then
            //with PurchLine do
                if PurchLine."Document Type" = PurchLine."Document Type"::Order then begin
                Clear(AVPurchLine);
                AVPurchLine.SetCurrentKey(AVPurchLine."Document Type", AVPurchLine."Document No.");
                AVPurchLine.SetFilter("AVTD_Ref. Doc. No.", PurchLine."Document No.");
                AVPurchLine.SetRange("AVTD_Ref. Line No.", PurchLine."Line No.");
                if AVPurchLine.FindFirst() then begin
                    AVPurchLine."AVTD_Ref. Doc. No." := '';
                    AVPurchLine."AVTD_Ref. Line No." := 0;
                    AVPurchLine."AVTD_COPY PR User Id" := '';
                    AVPurchLine."AVTD_Set PO No." := '';
                    AVPurchLine.Modify();
                end;
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', true, true)]
    local procedure OnAfterDeletePurchLineEvent(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        AfterDeletePurchLineEvent(Rec, RunTrigger);
    end;


    local procedure BeforeModifyEvent(var PurchLine: Record "Purchase Line"; var xPurchLine: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        //with PurchLine do
        if (PurchLine."Document Type" = PurchLine."Document Type"::Order) then
            if PurchLine."AVTD_Ref. Doc. No." <> '' then
                if (PurchLine.Type <> xPurchLine.Type) or
                    (PurchLine."No." <> xPurchLine."No.")/*  or
                        (PurchLine."FNGN004_G/L_Temp" <> xPurchLine."FNGN004_G/L_Temp") */ then
                    if PurchLine."AVTD_Ref. Doc. No." <> '' then
                        Error(PurchLine.FieldCaption("AVTD_Ref. Doc. No.") + ' already has value!');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        BeforeModifyEvent(Rec, xRec, RunTrigger);
    end;
}