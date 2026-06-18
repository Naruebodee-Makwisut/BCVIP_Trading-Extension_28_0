tableextension 70051 "AVTD_TAB38" extends "Purchase Header" //MyTargetTableId
{
    fields
    {
        field(50000; "AVTD_FINISHED"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished';
            Description = '//TD-003 สำหรับเก็บ Status Finished';
            Editable = false;
            //OptionMembers = " ",FINISHED;
        }
        field(50001; "AVTD_Purchase Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Status';
            Description = '//TD-003 สำหรับเก็บ Status ของ Purchase ทั้ง PR PO';
            Editable = false;
            OptionCaption = ' ,Fully,Final PO,Cancel';
            OptionMembers = " ",Fully,"Final PO",Cancel;
        }
        //TD-006
        field(50002; "AVTD_Finished PR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished PR';
        }
        field(50003; "AVTD_Cancel PR"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel PR';
        }
        //TD-006
    }

}