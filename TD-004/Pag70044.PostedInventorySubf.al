page 70044 "AVTD_Posted Inventory Subf"
{
    // version AVTHLC1.0,AVTSTNAV.01
    Caption = 'Posted Inventory Sub form';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Item Ledger Entry";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = Line;
                action(action1000000004)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        Rec.ShowDimensions();
                    end;
                }
            }
        }
    }
}

