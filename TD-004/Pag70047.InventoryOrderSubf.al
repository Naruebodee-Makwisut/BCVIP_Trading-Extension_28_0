page 70047 "AVTD_Inventory Order Subf"
{
    // version AVTHLC1.0,AVTSTNAV.01
    Caption = 'Inventory Order Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if Rec."Item No." <> '' then begin
                            CLEAR(IssueHead);
                            if IssueHead.GET(Rec."Document No.") then
                                Rec."Shortcut Dimension 1 Code" := IssueHead."Shortcut Dimension 1 Code";
                        end;
                    end;
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

                    trigger OnValidate();
                    begin
                        if Rec.Quantity < 0 then
                            Error('Quantity must be positive');
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Line)
            {
                Caption = 'Line';
                Image = Line;
                action("Assign LOT/SN")
                {
                    Caption = 'Assign LOT/SN';
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        OpenIssueTrackingLines();
                    end;
                }
                action(action1000000004)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        AVDimensions();
                    end;
                }
                action(action1000000008)
                {
                    Caption = 'ShowItemCard';
                    Image = Item;
                    ApplicationArea = All;
                    trigger OnAction();
                    begin
                        ShowItemCard();
                    end;
                }
            }
        }
    }
    /* trigger OnInit() 
    begin

    end; */
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Rec.Validate("Document No.", Rec."Journal Batch Name");

        Clear(IssueHead);
        IssueHead.Get(Rec."Document No.");
        Rec."Source Code" := 'ITEMJNL';
        Rec."Posting Date" := IssueHead."Posting Date";
        Rec.Validate("Salespers./Purch. Code", IssueHead."Requested By");
        //remove "Customer Code" because consult not use
        //VALIDATE("Customer Code", IssueHead."Customer No.");
        Rec.Validate("Shortcut Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Entry Type" := Rec."Entry Type"::"Negative Adjmt.";
        Rec.VALIDATE("Document No.", Rec."Journal Batch Name");

        CLEAR(IssueHead);
        IssueHead.GET(Rec."Document No.");
        Rec."Source Code" := 'ITEMJNL';
        Rec."Posting Date" := IssueHead."Posting Date";
        Rec.VALIDATE("Salespers./Purch. Code", IssueHead."Requested By");
        //comment "Customer Code" not use approve by consult
        //VALIDATE("Customer Code", IssueHead."Customer No.");
        Rec.VALIDATE("Shortcut Dimension 1 Code", IssueHead."Shortcut Dimension 1 Code");
    end;

    var
        IssueHead: Record "AVTD_Issue Header";
    /* ItemJournalLine: Record "Item Journal Line";
    UserSetup: Record "User Setup";
    InvSetup: Record "Inventory Setup"; */

    procedure OpenIssueTrackingLines();
    begin
        Rec.OpenItemTrackingLines(false);
    end;

    procedure AVDimensions();
    begin
        Rec.ShowDimensions();
    end;

    procedure ItemJnlExplodBOM();
    begin
        Codeunit.Run(Codeunit::"Item Jnl.-Explode BOM", Rec);
    end;

    procedure ShowItemCard();
    var
        Item: Record Item;
    begin
        Clear(Item);
        Item.SetRange("No.", Rec."Item No.");
        Page.Run(Page::"Item Card", Item);
    end;
}

