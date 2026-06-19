tableextension 70050 "AVTD_TAB36" extends "Sales Header" //MyTargetTableId
{
    fields
    {
        field(50001; "AVTD_FINISHED"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished';
            Description = '//TD-003 สำหรับเก็บ Status Finished';
            Editable = false;
            //OptionMembers = " ",FINISHED;
        }
        field(50002; "AVTD_Sales Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Status';
            Description = '//TD-003 สำหรับเก็บ Status ของ Purchase ทั้ง PR PO';
            Editable = false;
            OptionCaption = ' ,Fully,Final SO,Cancel';
            OptionMembers = " ",Fully,"Final SO",Cancel;
        }
        /* field(50002; "AVTD_Cancel"; Boolean)
        {
            CaptionML = ENU = 'Cancel';
            Description = '//AVNCCSTD.002 18/06/2012 ถ้าติ๊กแสดงว่า SO ถูกยกเลิกแล้ว';
            Editable = false;
            DataClassification = ToBeClassified;

        } */
        field(50005; "AVTD_Finished SQ"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished SQ';
        }
        field(50006; "AVTD_Cancel SQ"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancel SQ';
        }
    }

}