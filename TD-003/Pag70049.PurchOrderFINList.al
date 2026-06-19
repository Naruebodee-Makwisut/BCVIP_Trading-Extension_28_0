page 70049 "AVTD_Purch. Order-FIN List"
{
    // version AVTHLC1.0

    Caption = 'Purchase Orders FINISHED';
    CardPageID = "AVTD_Purch. Order-FINISHED";
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = filter(Order),
                            AVTD_FINISHED = const(true));
    ApplicationArea = All;
    UsageCategory = Documents;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Vendor Authorization No."; Rec."Vendor Authorization No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(1);
                    end;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean;
                    begin
                        DimMgt.LookupDimValueCodeNoUpdate(2);
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Queue Status"; Rec."Job Queue Status")
                {
                    ApplicationArea = All;
                    Visible = JobQueueActive;
                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No."),
                              "Date Filter" = FIELD("Date Filter");
                Visible = true;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
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
                action(Statistics)
                {
                    ApplicationArea = All;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    begin
                        Rec.CalcInvDiscForHeader();
                        Commit();
                        Page.RUNMODAL(Page::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = field("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No.");
                }
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = Receipt;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action("Prepa&yment Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
                }
                action("Prepayment Credi&t Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Purchase Credit Memos";
                    RunPageLink = "Prepayment Order No." = field("No.");
                    RunPageView = sorting("Prepayment Order No.");
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
                action(Approvals)
                {
                    ApplicationArea = All;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction();
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        //For BC15
                        //ApprovalEntries.Setfilters(Database::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                        //For BC19
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                separator(Separator1000000027)
                {
                }
                /* action("Whse. Receipt Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Whse. Receipt Lines';
                    Image = ReceiptLines;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = const(39),
                                  "Source Subtype" = field("Document Type"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                } */
                action("In&vt. Put-away/Pick Lines")
                {
                    ApplicationArea = All;
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = const("Purchase Order"),
                                  "Source No." = field("No.");
                    RunPageView = sorting("Source Document", "Source No.", "Location Code");
                }
                separator(Separator1000000024)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    action("Get &Sales Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Get &Sales Order';
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    action(Action1000000019)
                    {
                        ApplicationArea = All;
                        Caption = 'Get &Sales Order';
                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            //how to fix
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            //DistIntegration.GetSpecialOrders();
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Separator1000000017)
                {
                }
                /* action("Edit Qty to Receive")
                {
                    ApplicationArea = All;
                    Caption = 'Edit Qty to Receive';
                    Image = CalculateConsumption;
                    RunObject = Page Page50071;
                    RunPageLink = Field3=FIELD("No."),
                                  Field1=FIELD("Document Type");
                    Visible = false;
                } */
            }
            group("&Print")
            {
                Caption = '&Print';
                action("Purchase Order")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Order';
                    Image = PrintForm;

                    trigger OnAction();
                    begin
                        /*
                        CLEAR(AVPurchH);
                        CurrPAGE.SETSELECTIONFILTER(AVPurchH);
                        //AVTSJSL.014
                        //REPORT.RUNMODAL(50008,TRUE,FALSE,AVPurchH);
                        //REPORT.RUNMODAL(50006,TRUE,FALSE,AVPurchH);
                        REPORT.RUNMODAL(REPORT::"Purchase - Order",TRUE,FALSE,AVPurchH);  //50006
                        //AVTSJSL.014
                        */

                        //AVKIYSTD02.001 27.06.12
                        CLEAR(AVPurchH);
                        CurrPage.SetSelectionFilter(AVPurchH);
                        Report.RunModal(Report::"Order", true, false, AVPurchH);
                        //C-AVKITSTD02.001

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        Rec.SetSecurityFilterOnRespCenter();
        JobQueueActive := PurchasesPayablesSetup.JobQueueActive();
    end;

    var
        AVPurchH: Record "Purchase Header";
        DimMgt: Codeunit DimensionManagement;
        /* ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print"; */
        // [InDataSet]
        JobQueueActive: Boolean;

}

