tableextension 70057 "AVTD_TAB83" extends "Item Journal Line" //MyTargetTableId
{
    fields
    {
        field(50000; "AVTD_Customer Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Code';
            Description = '//TD-004 ÊÓËÃÑºà¡çº Customer No.';
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                IssueH: Record "AVTD_Issue Header"; //AVBCLSVIP.OP.46 Validate F.Gen Prod. Posting Group
            begin
                /* //AVNVKSTD.001 02/05/13
                //Add code for Keep Dim form Issue Header
                Clear(IssueH);
                IF IssueH.Get("Document No.") THEN BEGIN
                    Validate("Salespers./Purch. Code", IssueH."Requested By");
                    Validate("Customer Code", IssueH."Customer No.");
                    "Posting Date" := IssueH."Posting Date";
                    Validate("Gen. Bus. Posting Group", IssueH."Gen. Bus Posting Group");
                    Validate("Shortcut Dimension 1 Code", IssueH."Shortcut Dimension 1 Code");
                END;
                //C-AVNVKSTD.001 02/05/13 */
                //Message('sales : %1\ Customer : %2\ Gen Bus. Posting Group : %3\ Shortcut : %4', IssueH."Requested By", IssueH."Customer No.", IssueH."Gen. Bus Posting Group", IssueH."Shortcut Dimension 1 Code");

                //AVBCLSVIP.OP.46 Validate F.Gen Prod. Posting Group
                Clear(IssueH);
                IF IssueH.Get("Document No.") THEN BEGIN
                    Rec.Validate("Gen. Prod. Posting Group", IssueH."Gen. Prod Posting Group");
                END;
                //C-AVBCLSVIP.OP.46 Validate F.Gen Prod. Posting Group
            end;
        }
    }
}