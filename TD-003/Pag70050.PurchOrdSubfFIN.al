page 70050 "AVTD_Purch.Ord Subf-FIN"
{
    // version AVTHLC1.0

    Caption = 'Purchase Order Subform';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Purchase Line";
    SourceTableView = where("Document Type" = filter(Order));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                /*  field("Ref. Doc. No."; "Ref. Doc. No.")
                 {
                     Editable = false;
                 }
                 field("Ref. Line No."; "Ref. Line No.")
                 {
                     Editable = false;
                 }
                 field("G/L_Temp"; "G/L_Temp")
                 {
                     Visible = false;
                 } */
                field(Type; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                        NoOnAfterValidate();
                    end;
                }
                field(Description; Rec."Description")
                {
                    ApplicationArea = All;
                }
                //Obsolete Tag 17.0
                /* field("Cross-Reference No."; "Cross-Reference No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        CrossReferenceNoLookUp();
                        InsertExtendedText(false);
                    end;

                    trigger OnValidate();
                    begin
                        CrossReferenceNoOnAfterValidat();
                    end;
                } */
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Nonstock; Rec."Nonstock")
                {
                    ApplicationArea = All;
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
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("WHT Business Posting Group"; Rec."AVF_WHT Business Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("WHT Product Posting Group"; Rec."AVF_WHT Product Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Quantity; Rec."Quantity")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Visible = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                /* field("Line Discount 1 %"; "Line Discount 1 %")
                {
                }
                field("Line Discount Amount 1"; "Line Discount Amount 1")
                {
                }
                field("Line Discount 2 %"; "Line Discount 2 %")
                {
                }
                field("Line Discount Amount 2"; "Line Discount Amount 2")
                {
                }
                field("Line Discount 3 %"; "Line Discount 3 %")
                {
                }
                field("Line Discount Amount 3"; "Line Discount Amount 3")
                {
                } */
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnDrillDown();
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                    BlankZero = true;

                    trigger OnDrillDown();
                    begin
                        CurrPage.SaveRecord();
                        Rec.ShowItemChargeAssgnt();
                        UpdateForm(false);
                    end;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Finished; Rec."Finished")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(3, ShortcutDimCode[3]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(4, ShortcutDimCode[4]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(5, ShortcutDimCode[5]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(6, ShortcutDimCode[6]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(7, ShortcutDimCode[7]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        Rec.LookupShortcutDimCode(8, ShortcutDimCode[8]);
                    end;

                    trigger OnValidate();
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;
                    action(Events)
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByEvent())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::"Event"); //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByPeriod())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Period); //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
                        end;
                    }
                    action("Variant")
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByVariant())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Variant); //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = Warehouse;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByLocation())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::Location); //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        Image = BOMLevel;

                        trigger OnAction();
                        begin
                            // ItemAvailFormsMgt.ShowItemAvailFromPurchLine(Rec, ItemAvailFormsMgt.ByBOM())
                            PurchAvailabilityMgt.ShowItemAvailabilityFromPurchLine(Rec, "Item Availability Type"::BOM); //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
                        end;
                    }
                }
                action("Reservation Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction();
                    begin
                        Rec.ShowReservationEntries(true);
                    end;
                }
                action("Item Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction();
                    begin
                        avOpenItemTrackingLines();
                    end;
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        avShowDimensions();
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction();
                    begin
                        avShowLineComments();
                    end;
                }
                action(ItemChargeAssignment)
                {
                    ApplicationArea = All;
                    Caption = 'Item Charge &Assignment';

                    trigger OnAction();
                    begin
                        Rec.ShowItemChargeAssgnt();
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("E&xplode BOM")
                {
                    ApplicationArea = All;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;

                    trigger OnAction();
                    begin
                        ExplodeBOM();
                    end;
                }
                action("Insert Ext. Texts")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;

                    trigger OnAction();
                    begin
                        InsertExtendedText(true);
                    end;
                }
                action(Reserve)
                {
                    ApplicationArea = All;
                    Caption = '&Reserve';
                    Ellipsis = true;
                    Image = Reserve;

                    trigger OnAction();
                    begin
                        Rec.Find();
                        avShowReservation();
                    end;
                }
                action(OrderTracking)
                {
                    ApplicationArea = All;
                    Caption = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction();
                    begin
                        ShowTracking();
                    end;
                }
            }
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Sales &Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction();
                        begin
                            OpenSalesOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action1000000003)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales &Order';
                        Image = Document;

                        trigger OnAction();
                        begin
                            OpenSpecOrderSalesOrderForm();
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnDeleteRecord(): Boolean;
    var
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
    begin
        if (Rec.Quantity <> 0) and Rec.ItemExists(Rec."No.") then begin
            Commit();
            if not ReservePurchLine.DeleteLineConfirm(Rec) then
                exit(false);
            ReservePurchLine.DeleteLine(Rec);
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.Type := xRec.Type;
        Clear(ShortcutDimCode);
    end;



    procedure ApproveCalcInvDisc();
    begin
        Codeunit.Run(Codeunit::"Purch.-Disc. (Yes/No)", Rec);

    end;

    procedure CalcInvDisc();
    begin
        Codeunit.Run(Codeunit::"Purch.-Calc.Discount", Rec);
    end;

    procedure ExplodeBOM();
    begin
        if Rec."Prepmt. Amt. Inv." <> 0 then
            Error(Text001Err);
        Codeunit.Run(Codeunit::"Purch.-Explode BOM", Rec);
    end;

    procedure OpenSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TestField("Sales Order No.");
        SalesHeader.SetRange("No.", Rec."Sales Order No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run();
    end;

    procedure InsertExtendedText(Unconditionally: Boolean);
    begin
        if TransferExtendedText.PurchCheckIfAnyExtText(Rec, Unconditionally) then begin
            CurrPage.SaveRecord();
            TransferExtendedText.InsertPurchExtText(Rec);
        end;
        if TransferExtendedText.MakeUpdate() then
            UpdateForm(true);
    end;

    procedure avShowReservation();
    begin
        Rec.find();
        Rec.ShowReservation();
    end;

    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin);
    begin
        ItemAvailability(AvailabilityType);
    end;

    procedure ShowReservationEntries();
    begin
        Rec.ShowReservationEntries(true);
    end;

    procedure ShowTracking();
    var
        TrackingForm: Page "Order Tracking";
    begin
        //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
        Rec.ShowOrderTracking();
        // TrackingForm.SetPurchLine(Rec);
        // TrackingForm.RunModal();
        //C-AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
    end;

    procedure avShowDimensions();
    begin
        Rec.ShowDimensions();
    end;

    procedure ItemChargeAssgnt();
    begin
        Rec.ShowItemChargeAssgnt();
    end;

    procedure avOpenItemTrackingLines();
    begin
        Rec.OpenItemTrackingLines();
    end;

    procedure OpenSpecOrderSalesOrderForm();
    var
        SalesHeader: Record "Sales Header";
        SalesOrder: Page "Sales Order";
    begin
        Rec.TestField("Special Order Sales No.");
        SalesHeader.SetRange("No.", Rec."Special Order Sales No.");
        SalesOrder.SetTableView(SalesHeader);
        SalesOrder.Editable := false;
        SalesOrder.Run();
    end;

    procedure UpdateForm(SetSaveRecord: Boolean);
    begin
        CurrPage.Update(SetSaveRecord);
    end;

    procedure SetUpdateAllowed(UpdateAllowed: Boolean);
    begin
        UpdateAllowedVar := UpdateAllowed;
    end;

    procedure UpdateAllowed(): Boolean;
    begin
        if UpdateAllowedVar = false then begin
            Message(Text000Err);
            exit(false);
        end else
            exit(true);
    end;

    /* procedure ShowPrices();
    begin
        PurchHeader.Get("Document Type", "Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    procedure ShowLineDisc();
    begin
        PurchHeader.Get("Document Type", "Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end; */

    procedure avShowLineComments();
    begin
        Rec.ShowLineComments();
    end;

    local procedure NoOnAfterValidate();
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord();
    end;

    local procedure CrossReferenceNoOnAfterValidat();
    begin
        InsertExtendedText(false);
    end;

    var
        PurchHeader: Record "Purchase Header";
        TransferExtendedText: Codeunit "Transfer Extended Text";
        PurchAvailabilityMgt: Codeunit "Purch. Availability Mgt."; //AVNMTBCVIP.26.1 18/08/2025 Update for BC.26
        //PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        //TransferExtendedText 
        ShortcutDimCode: array[8] of Code[20];
        UpdateAllowedVar: Boolean;
        Text000Err: Label 'Unable to execute this function while in view only mode.';
        //PurchInfoPaneMgt: Codeunit "Purchases Info-Pane Management";
        Text001Err: Label 'You can not use the Explode BOM function because a prepayment of the purchase order has been invoiced.';

}

