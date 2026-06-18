pageextension 70056 "AVTD_PAG42" extends "Sales Order"
{
    layout
    {
        addafter("AVF_Customer Branch No.")
        {
            field("AVTD_Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("AVTD_Sales Status"; Rec."AVTD_Sales Status")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {
            action("AVTD_FINISHED SO")
            {
                ApplicationArea = All;
                Caption = 'FINISHED SO';
                Image = CreateInventoryPickup;

                trigger OnAction();
                begin
                    //AVTSTSTD.011 01/07/2012
                    //Add code for call function Finish Sales Order on trigger <Control1000000003> - OnPush()
                    SOFunction.FinishSO(Rec);
                    //end - AVTSTSTD.011 01/07/2012
                end;
            }
            action("AVTD_Cancel SO")
            {
                ApplicationArea = All;
                Caption = 'Cancel SO';
                Image = CancelAllLines;

                trigger OnAction();
                begin
                    //AVNCCSTD.009 20.06.2012
                    //Add code for call function Cancel SO on trigger <Control1000000027> - OnPush()
                    //CancelSO;
                    SOFunction.CancelSO(Rec);
                    //E-AVNCCSTD.009 20.06.2012
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("AVTD_FINISHED SO_Promoted"; "AVTD_FINISHED SO")
            {
            }
            actionref("AVTD_Cancel SO_Promoted"; "AVTD_Cancel SO")
            {
            }
        }
    }
    var
        SOFunction: Codeunit "AVTD_SO Function";
}