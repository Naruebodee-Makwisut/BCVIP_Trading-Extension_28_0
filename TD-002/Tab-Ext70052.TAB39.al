tableextension 70052 "AVTD_TAB39" extends "Purchase Line" //MyTargetTableId
{
    fields
    {
        field(50001; "AVTD_Ref. Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Ref. Docu No.';
            Description = '//TD-002 สำหรับเก็บค่า Document No. เมื่อใช้ function Get PR Line';
        }
        field(50002; "AVTD_Ref. Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ref. Line No.';
            Description = '//TD-002 สำหรับเก็บค่า Line No. เมื่อใช้ function Get PR Line';
        }
        field(50003; "AVTD_Used Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Used Line';
            Description = '//TD-002 สำหรับระบุว่าถูกใช้ไปแล้วเมื่อใช้ function Get PR Line';
        }
        field(50004; "AVTD_Purchase Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Status';
            Description = '//TD-003 สำหรับเก็บ Status ของ Purchase ทั้ง PR PO';
            Editable = false;
            OptionCaption = ' ,Fully,Final PO,Cancel';
            OptionMembers = " ",Fully,"Final PO",Cancel;

        }
        field(50005; "AVTD_Set PO No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Set PO No.';
            Description = 'keep po no. for function copy pr line.';
        }
        field(50006; "AVTD_COPY PR User Id"; Code[50])
        {
            Caption = 'COPY PR User ID';
            DataClassification = EndUserIdentifiableInformation;
            NotBlank = true;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            Description = 'keep user id for function copy pr line';
        }

        /*Fix from Aire request*/
        modify(Type)
        {
            trigger OnBeforeValidate()
            begin
                if ("AVTD_Ref. Doc. No." <> '') or ("AVTD_Ref. Line No." <> 0) then
                    FieldError("No.", 'Cannot change No. Ref. Doc No. already has value.');
            end;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                if ("AVTD_Ref. Doc. No." <> '') or ("AVTD_Ref. Line No." <> 0) then
                    FieldError("No.", 'Cannot change No. Ref. Doc No. already has value.');
            end;
        }
    }
    /* trigger OnBeforeModify()
    begin
        if ("AVTD_Ref. Doc. No." <> '') or ("AVTD_Ref. Line No." <> 0) then
                    FieldError("No.", 'Cannot change No. Ref. Doc No. already has value.');
    end; */

}