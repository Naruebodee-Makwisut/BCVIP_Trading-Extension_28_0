page 70045 "AVTD_Inventory Order List"
{
    // version AVTHLC1.0,AVTSTNAV.01
    Caption = 'Inventory Order List';
    CardPageID = "AVTD_Inventory Order";
    Editable = false;
    PageType = List;
    SourceTable = "AVTD_Issue Header";
    SourceTableView = sorting("Issue No.")
                      where(Status = filter(Order));
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Issue No."; Rec."Issue No.")
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Sales_Person_Name"; SalesPersonName)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
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

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                //comment by consult
                /* field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                } */
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field("Remark 2"; Rec."Remark 2")
                {
                    ApplicationArea = All;
                }
                field("EVG Job No."; Rec."EVG Job No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                    Visible = true;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name';
                    Style = Standard;
                    StyleExpr = TRUE;
                }

                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Card;
                    ShortCutKey = 'Shift+F5';

                    trigger OnAction();
                    begin
                        Page.Run(Page::"AVTD_Inventory Order", Rec);
                    end;
                }
            }
        }
    }
    //comment from consult
    /* trigger OnAfterGetRecord();
    begin
        CLEAR(CustomerName);
        CLEAR(Cust);
        if Cust.GET("Customer No.") then
            CustomerName := Cust.Name;
    end; */
    //add new 
    /* trigger OnAfterGetCurrRecord()
    begin
        SalesPersonName := ShowSalePersonName("Requested By");
    end; */
    trigger OnAfterGetRecord()
    begin
        SalesPersonName := Rec.ShowSalePersonName(Rec."Requested By");
    end;
    //c-add new

    var
        SalesPersonName: Text[100];
    /* CustomerName: Text[100];
    SalesPerson: Record "Salesperson/Purchaser";
    Cust: Record Customer; */
}

