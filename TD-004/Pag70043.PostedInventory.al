page 70043 "AVTD_Posted Inventory"
{
    // version AVTHLC1.0,AVTSTNAV.01
    Caption = 'Posted Inventory';
    Editable = false;
    PageType = Card;
    SourceTable = "AVTD_Issue Header";
    SourceTableView = sorting("Issue No.")
                      where(Status = filter(Posted));

    layout
    {
        area(content)
        {
            group("MAIN FORM")
            {
                Caption = 'General';
                field("Issue No."; Rec."Issue No.")
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Sales_Person_Name"; SalesPersonName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                //comment approve by consult
                /* field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Editable = false;
                } */
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Remark 2"; Rec."Remark 2")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod Posting Group"; Rec."Gen. Prod Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                    Visible = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Subform; "AVTD_Posted Inventory Subf")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Document No." = field("Issue No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Print)
            {
                Caption = 'Print';
                Visible = false;
                /*action("Stock Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Stock Issue';
                    Image = CalculateInventory;

                    trigger OnAction();
                    begin
                        CurrPage.SetSelectionFilter(IssueHeader);
                        Report.RunModal(50089, true, false, IssueHeader);
                    end;
                }
                 action("Check Qty For Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Check Qty For Issue';
                    Visible = false;

                    trigger OnAction();
                    begin
                        CurrPage.SetSelectionFilter(IssueHeader);
                        IssueHeader.SetRange("Plant No.", "Plant No.");
                        Report.RunModal(50081, true, false, IssueHeader);

                    end;
                } */
                action("&Print")
                {
                    ApplicationArea = All;
                    Caption = '&Print';
                    Image = Print;

                    trigger OnAction();
                    begin
                        //CurrPage.SETSELECTIONFILTER(IssueHeader);
                        CurrPage.SetSelectionFilter(IssueHeader);
                        Report.RunModal(Report::"AVTD_Issue Inventory", true, false, IssueHeader);
                    end;
                }
            }
            group(Issue)
            {
                Caption = 'Issue';
                separator(Separator1000000039)
                {
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        Rec.ShowPostedDocDim();
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref("&Print_Promoted"; "&Print")
                {
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //OnAfterGetCurrRecord;
    end;

    trigger OnAfterGetCurrRecord();
    begin
        xRec := Rec;

        //SalesPersonName := SalesPerson.ShowSalePersonName("Requested By");
        SalesPersonName := Rec.ShowSalePersonName(Rec."Requested By");
        //comment approve by consult
        /*  CLEAR(CustomerName);
         if Cust.GET("Customer No.") then
             CustomerName := Cust.Name; */
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Rec."User Id" := UserId();
    end;

    var
        IssueHeader: Record "AVTD_Issue Header";
        SalesPersonName: Text[100];
    /* CustomerName: Text[100];
    SalesPerson: Record "Salesperson/Purchaser";
    Cust: Record Customer; */

    /*local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;

        SalesPersonName := SalesPerson.ShowSalePersonName("Requested By");

        CLEAR(CustomerName);
        if Cust.GET("Customer No.") then
          CustomerName := Cust.Name;
    end;*/
}

