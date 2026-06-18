page 70052 "AVTD_Sales Order - Finished"
{
    // version AVTHLC1.0

    // 001   20.06.2012   AVNCCSTD  Add code for call function UnfinishSO
    Caption = 'Sales Order - Finished';
    Editable = false;
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = sorting("Document Type", "No.")
                      where("Document Type" = filter(Order),
                            AVTD_FINISHED = const(true));
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        /* if AssistEdit(xRec) then
                          CurrPage.UPDATE; */
                    end;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SelltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 3"; Rec."AVF_Sell-to Address 3")
                {
                    ApplicationArea = All;
                }
                field("Sell-to City"; Rec."Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; Rec."Sell-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to Post Code/City';
                }
                field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sell-to County/Country Code';
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field(FINISHED; Rec."AVTD_FINISHED")
                {
                    ApplicationArea = All;
                }
                /* field(Cancel; "Cancel")
                {
                    ApplicationArea = All;
                } */
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                /* field("Customer Order No."; "Customer Order No.")
                {
                    Editable = false;
                } */
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SalespersonCodeOnAfterValidate();
                    end;
                }
                field(Status; Rec."Status")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Sell-to County"; Rec."Sell-to County")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Delivery Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Promised Delivery Date"; Rec."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Campaign No."; Rec."Campaign No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Opportunity No."; Rec."Opportunity No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            part(SalesLines; "Sales Order Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                Caption = 'Lines';
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        Clear(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        if ChangeExchangeRate.RunModal() = Action::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.Update();
                        end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrencyCodeOnAfterValidate();
                    end;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BilltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 3"; Rec."AVF_Bill-to Address 3")
                {
                    ApplicationArea = All;
                }
                field("Bill-to City"; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Post Code/City';
                }
                field("Bill-to Contact"; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV();
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV();
                    end;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        PricesIncludingVATOnAfterValid();
                    end;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(SelectedPayments; Rec."GetSelectedPaymentServicesText"())
                {
                    ApplicationArea = All;
                    Caption = 'Payment Service';
                    Editable = false;
                    Enabled = PaymentServiceEnabled;
                    MultiLine = true;
                    ToolTip = 'Specifies the online payment service, such as PayPal, that customers can use to pay the sales document.';

                    trigger OnAssistEdit();
                    begin
                        Rec.ChangePaymentServiceSetting();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to County"; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to County/Country Code';
                    Visible = false;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 3"; Rec."AVF_Ship-to Address 3")
                {
                    ApplicationArea = All;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code/City';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Outbound Whse. Handling Time"; Rec."Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Late Order Shipping"; Rec."Late Order Shipping")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
#if not CLEAN24
                field("Package Tracking No."; Rec."Package Tracking No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
#endif
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("<Shipping Advice1 >"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to County/Country Code';
                    Visible = false;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Visible = false;
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec."Area")
                {
                    ApplicationArea = All;
                }
            }
            group(Prepayment)
            {
                Caption = 'Prepayment';
                Visible = false;
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Prepayment37OnAfterValidate();
                    end;
                }
                field("Compress Prepayment"; Rec."Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; Rec."Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; Rec."Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000020; "Sales Hist. Sell-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Sell-to Customer No.");
                Visible = true;
            }
            part(Control1000000019; "Customer Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            part(Control1000000017; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Sell-to Customer No.");
                Visible = false;
            }
            part(Control1000000015; "Sales Line FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "Document Type" = field("Document Type"),
                              "Document No." = field("Document No."),
                              "Line No." = field("Line No.");
                Visible = true;
            }
            part(Control1000000013; "Item Invoicing FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                Visible = false;
            }
            part(Control1000000011; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(36),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No.");
                Visible = false;
            }
            part(Control1000000009; "Resource Details FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                Visible = false;
            }
            part(Control1000000007; "Item Warehouse FactBox")
            {
                ApplicationArea = All;
                Provider = SalesLines;
                SubPageLink = "No." = field("No.");
                Visible = false;
            }
            part(Control1000000005; "Sales Hist. Bill-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Bill-to Customer No.");
                Visible = false;
            }
            systempart(Control1000000001; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1000000003; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Visible = false;
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        Commit();
                        Page.RunModal(Page::"Sales Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = field("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
                action("S&hipments")
                {
                    ApplicationArea = All;
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = Sorting("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = Sorting("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = Sorting("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = Sorting("Prepayment Order No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
                action("A&pprovals")
                {
                    ApplicationArea = All;
                    Caption = 'A&pprovals';
                    Image = Approvals;

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //For BC15-BC18
                        //ApprovalEntries.Setfilters(DATABASE::"Sales Header", Rec."Document Type".AsInteger(), Rec."No.");
                        //For BC19
                        ApprovalEntries.SetRecordFilters(Database::"Sales Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                separator(Separator173)
                {
                }
                /* action("Whse. Shipment Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Shipment Lines';
                    Image = GetLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = const(37),
                                  "Source Subtype" = field("Document Type"),
                                  "Source No." = field("No.");
                    RunPageView = Sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                } */
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = const("Sales Order"),
                                  "Source No." = field("No.");
                    RunPageView = Sorting("Source Document", "Source No.", "Location Code");
                }
                separator(Separator120)
                {
                }
                action("Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Pla&nning';
                    Image = Planning;

                    trigger OnAction();
                    var
                        SalesPlanForm: Page "Sales Order Planning";
                    begin
                        SalesPlanForm.SetSalesOrder(Rec."No.");
                        SalesPlanForm.RunModal();
                    end;
                }
                action("Order &Promising")
                {
                    ApplicationArea = All;
                    Caption = 'Order &Promising';
                    Image = OrderPromising;

                    trigger OnAction();
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SetRange("Source Type", Rec."Document Type");
                        OrderPromisingLine.SetRange("Source ID", Rec."No.");
                        Page.RunModal(Page::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Purchase &Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.Page.OpenPurchOrderForm();
                        end;
                    }
                }
                group("Speci&al Order")
                {

                    Caption = 'Speci&al Order';
                    Image = Reconcile;
                    action(Action203)
                    {
                        ApplicationArea = All;
                        Caption = 'Purchase &Order';

                        trigger OnAction();
                        begin
                            CurrPage.SalesLines.Page.OpenSpecialPurchOrderForm();
                        end;
                    }
                }
                separator(Separator258)
                {
                }
                /* action("Credit Cards Transaction Lo&g Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Credit Cards Transaction Lo&g Entries',
                                THA = 'รายการบัน&ทึกธุรกรรมบัตรเครดิต';
                    Image = CreditCardLog;
                    RunObject = Page Page829;
                    RunPageLink = Field2=field("Document Type"),
                                  Field3=field("No."),
                                  Field4=field("Bill-to Customer No.");
                } */
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Undo Finish SO")
                {
                    ApplicationArea = All;
                    Caption = 'Undo Finish SO';
                    Image = ReverseLines;
                    //Promoted = true;
                    //PromotedCategory = Process;
                    trigger OnAction();
                    begin
                        //AVNCCSTD.001 20.06.2012
                        //IF CONFIRM('Do you want to Confirm Undo FINISHD SO No. %1 ?',TRUE,"No.") THEN
                        SOFunction.UnfinishSO(Rec);
                        //E-AVNCCSTD.001 20.06.2012
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Visible = false;
                action("Order Confirmation")
                {
                    ApplicationArea = All;
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Confirm;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = PrintCover;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
                action("Pick Ticket")
                {
                    ApplicationArea = All;
                    Caption = 'Pick Ticket';
                    Image = PrintForm;

                    trigger OnAction();
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Pick Ticket");
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';
                group(Category_Category7)
                {
                    Caption = 'Function';
                    actionref("Undo Finish SO_Promoted"; "Undo Finish SO")
                    {
                    }
                }

            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SaveRecord();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    begin
        SalesHistoryStnVisible := true;
        BillToCommentBtnVisible := true;
        BillToCommentPictVisible := true;
        SalesHistoryBtnVisible := true;
    end;

    trigger OnOpenPage();
    begin
        if UserMgt.GetSalesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetSalesFilter());
            Rec.FilterGroup(0);
        end;

        Rec.SetRange("Date Filter", 0D, WorkDate() - 1);
    end;

    var
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        SOFunction: Codeunit "AVTD_SO Function";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Usage: Option "Order Confirmation","Work Order","Pick Ticket";
        Text000Err: label 'Unable to execute this function while in view only mode.';
        // [InDataSet]
        SalesHistoryBtnVisible: Boolean;
        // [InDataSet]
        BillToCommentPictVisible: Boolean;
        // [InDataSet]
        BillToCommentBtnVisible: Boolean;
        // [InDataSet]
        SalesHistoryStnVisible: Boolean;
        PaymentServiceEnabled: Boolean;
    /* Text19070588: TextConst ENU = 'Sell-to Customer', THA = 'ขายให้ลูกค้า';
    Text19069283: TextConst ENU = 'Bill-to Customer', THA = 'เก็บเงินจากลูกค้า'; */
    //PaymentServiceVisible: Boolean;

    /* SalesSetup: Record "Sales & Receivables Setup";
    ReportPrint: Codeunit "Test Report-Print"; */
    /* ArchiveManagement: Codeunit ArchiveManagement;
    SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management"; */
    /* CopySalesDoc: Report "Copy Sales Document";
    MoveNegSalesLines: Report "Move Negative Sales Lines"; */
    /* Text001: TextConst ENU = 'There are non posted Prepayment Amounts on %1 %2.', THA = 'ไม่มียอดการชำระเงินล่วงหน้าที่ลงรายการบัญชีใน %1 %2';
    Text002: TextConst ENU = 'There are unpaid Prepayment Invoices related to %1 %2.', THA = 'มีใบแจ้งหนี้ที่ยังไม่ได้ชำระเงินเกี่ยวข้องกับ %1 %2';
    Text003: Label 'Please select Sales Person Code before Released.';
    Text004: Label 'Please Released before post Document.'; */

    procedure UpdateAllowed(): Boolean;
    begin
        if CurrPage.Editable() = false then
            Error(Text000Err);
        exit(true);
    end;

    local procedure UpdateInfoPanel();
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := Rec."Sell-to Customer No." <> Rec."Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
        /*
        SalesHistoryStnVisible := SalesInfoPaneMgt.DocExist(Rec,"Sell-to Customer No.");
        IF DifferSellToBillTo THEN
          SalesHistoryBtnVisible := SalesInfoPaneMgt.DocExist(Rec,"Bill-to Customer No.")
        */

    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.SalesLines.Page.ApproveCalcInvDisc();
    end;

    local procedure SelltoCustomerNoOnAfterValidat();
    begin
        CurrPage.Update();
    end;

    local procedure SalespersonCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;

    local procedure BilltoCustomerNoOnAfterValidat();
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.Update();
    end;

    local procedure CurrencyCodeOnAfterValidate();
    begin
        CurrPage.SalesLines.Page.UpdateForm(true);
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        CurrPage.Update();
    end;
}

