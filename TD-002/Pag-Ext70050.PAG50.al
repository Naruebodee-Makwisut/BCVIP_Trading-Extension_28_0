pageextension 70050 "AVTD_PAG50" extends "Purchase Order" //MyTargetPageId
{
    layout
    {
        //TD-003
        addafter("AVF_Vendor Branch No.")
        {
            field("AVTD_Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("AVTD_Purchase Status"; Rec."AVTD_Purchase Status")
            {
                ApplicationArea = All;
            }
        }
        //C-TD-003
    }

    actions
    {
        //TD-003
        addlast("F&unctions")
        {
            action("AVTD_CANCEL PO")
            {
                ApplicationArea = All;
                Caption = '*** CANCEL PO ***';
                Image = Cancel;

                trigger OnAction();
                begin
                    //AVTSTSTD.003 01/07/2012
                    //Add code for call function Cancel PO on trigger <Control1000000001> - OnPush()
                    AVPR_Function."CANCEL PO"(Rec);
                    //end - AVTSTSTD.003 01/07/2012
                end;
            }
            action("AVTD_FINAL PO")
            {
                ApplicationArea = All;
                Caption = '*** FINAL PO ***';
                Image = ReleaseDoc;

                trigger OnAction();
                begin
                    //AVTSTSTD.004 01/07/2012
                    //Add code for call function FINAL PO on trigger <Control1000000002> - OnPush()
                    AVPR_Function."FINAL PO"(Rec);
                    //end - AVTSTSTD.004 01/07/2012
                end;
            }
        }
        //C-TD-003
        addbefore(CopyDocument)
        {
            action("AVTD_Copy PR Line")
            {
                Caption = 'Copy PR Line';
                ApplicationArea = All;
                Image = CopyDocument;

                trigger OnAction();
                var
                    PurchQuoteForm: Page "AVTD_PR Line List";
                    OK: Boolean;
                begin
                    Rec.TestField("Buy-from Vendor No.");

                    Clear(PurchQuoteForm);
                    PurchQuoteForm."GET DOCU NO."(Rec);
                    //PurchQuoteForm.LookupMode(false);
                    PurchQuoteForm.LookupMode(true);
                    OK := PurchQuoteForm.RunModal() = Action::LookupOK;
                    //PurchQuoteForm.RUN;
                    Clear(PurchQuoteForm);
                    if not OK then
                        exit;
                    //CurrPage.PurchLines.Page.UpdateForm(true);
                end;
            }
        }
        addfirst(Category_Process)
        {
            actionref("AVTD_Copy PR Line_Promoted"; "AVTD_Copy PR Line")
            {
            }
        }
        addlast(Category_Process)
        {
            actionref("AVTD_CANCEL PO_Promoted"; "AVTD_CANCEL PO")
            {
            }
            actionref("AVTD_FINAL PO_Promoted"; "AVTD_FINAL PO")
            {
            }
        }
    }
    var
        AVPR_Function: Codeunit "AVTD_PR Function";//TD-003
}