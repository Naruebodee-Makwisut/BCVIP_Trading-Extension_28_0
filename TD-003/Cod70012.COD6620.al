codeunit 70012 "AVTD_COD6620"
{
    EventSubscriberInstance = StaticAutomatic;
    local procedure BeforeModifyPurchHeader(var ToPurchHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer)
    begin
        //with ToPurchHeader do begin
        //AVNP_Fixed_LC.001
        ToPurchHeader."AVTD_Purchase Status" := ToPurchHeader."AVTD_Purchase Status"::" ";
        ToPurchHeader.AVTD_FINISHED := false;
        //C-AVNP_Fixed_LC.001
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeModifyPurchHeader', '', true, true)]
    local procedure OnBeforeModifyPurchHeader(var ToPurchHeader: Record "Purchase Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer);
    begin
        BeforeModifyPurchHeader(ToPurchHeader, FromDocType, FromDocNo, IncludeHeader, FromDocOccurenceNo, FromDocVersionNo);
    end;

    local procedure BeforeModifySalesHeader(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer)
    begin
        //with ToSalesHeader do begin
        //AVNP_Fixed_LC.001
        ToSalesHeader."AVTD_Sales Status" := ToSalesHeader."AVTD_Sales Status"::" ";
        ToSalesHeader.AVTD_FINISHED := false;
        //C-AVNP_Fixed_LC.001
        //end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeModifySalesHeader', '', true, true)]
    local procedure OnBeforeModifySalesHeader(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20]; IncludeHeader: Boolean; FromDocOccurenceNo: Integer; FromDocVersionNo: Integer);
    begin
        BeforeModifySalesHeader(ToSalesHeader, FromDocType, FromDocNo, IncludeHeader, FromDocOccurenceNo, FromDocVersionNo);
    end;
}