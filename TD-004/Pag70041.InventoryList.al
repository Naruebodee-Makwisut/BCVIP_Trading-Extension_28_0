page 70041 "AVTD_Inventory List"
{
    // version AVTHLC1.0
    Caption = 'Inventory List';
    CardPageID = "AVTD_Posted Inventory List";
    Editable = false;
    PageType = List;
    SourceTable = "AVTD_Issue Header";
    SourceTableView = sorting("Issue No.")
                      order(Ascending);
    //UsageCategory = Lists;
    //ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
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
                field("Issue No."; Rec."Issue No.")
                {
                    ApplicationArea = All;
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                //comment from consult
                /* field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field(AVCustomerName; AVCustomerName)
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
                field("Issue Type"; Rec."Issue Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name';
                    Style = Standard;
                    StyleExpr = TRUE;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("AVSales_Person_Name"; AVSalesPersonName)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
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
                        case Rec."Issue Type" of
                            Rec."Issue Type"::Positive:
                                Page.Run(Page::"AVTD_Posted Inventory", Rec);
                            Rec."Issue Type"::Negative:
                                Page.Run(Page::"AVTD_Posted Inventory Subf", Rec);
                            Rec."Issue Type"::Consumption:
                                Page.Run(Page::"AVTD_Posted Inventory List", Rec);
                        end;
                    end;
                }
            }
        }
    }
    //comment approve by consult
    /* trigger OnAfterGetRecord();
    begin
        CLEAR(AVCustomerName);
        CLEAR(AVCust);
        if AVCust.GET("Customer No.") then
            AVCustomerName := AVCust.Name;
    end; */

    var
        AVSalesPersonName: Text[100];
    /* AVCustomerName: Text[100];
    AVSalesPerson: Record "Salesperson/Purchaser";
    AVCust: Record Customer; */
}

