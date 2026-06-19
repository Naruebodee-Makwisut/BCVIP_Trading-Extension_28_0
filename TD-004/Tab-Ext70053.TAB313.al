tableextension 70053 "AVTD_TAB313" extends "Inventory Setup" //MyTargetTableId
{
    fields
    {
        field(50000; "AVTD_Iss. Jnl Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Journal Template Name';
            Description = '//TD-004';
            TableRelation = "Item Journal Template".Name;
        }
        field(50001; "AVTD_Iss. Jnl Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Journal Batch Name';
            Description = '//TD-004';
        }
        field(50002; "AVTD_Iss. Gen.Bus Post. Grp"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Gen. Bus Posting Group';
            Description = '//TD-004';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(50003; "AVTD_Issue Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Issue Nos.';
            Description = '//TD-004';
            TableRelation = "No. Series";
        }
    }

}