page 70048 "AVTD_Purch. Order-FINISHED"
{
    // version AVTHLC1.0

    Caption = 'Purchase Order - FINISHED';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = where("Document Type" = filter(Order),
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
                    Importance = Promoted;
                    Visible = DocNoVisible;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;

                    trigger OnValidate();
                    begin
                        BuyfromVendorNoOnAfterValidate();
                    end;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Buy-from Address 3"; Rec."AVF_Buy-from Address 3")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                }
                field("Buy-from County"; Rec."Buy-from County")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Buy-from County/Country Code';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Shipment No."; Rec."Vendor Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = VendorInvoiceNoMandatory;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;

                    trigger OnValidate();
                    begin
                        PurchaserCodeOnAfterValidate();
                    end;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Status; Rec."Status")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Purchase Status"; Rec."AVTD_Purchase Status")
                {
                    ApplicationArea = All;
                }
                field(FINISHED; Rec."AVTD_FINISHED")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "AVTD_Purch.Ord Subf-FIN")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnValidate();
                    begin
                        PaytoVendorNoOnAfterValidate();
                    end;
                }
                field("Pay-to Contact No."; Rec."Pay-to Contact No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Name"; Rec."Pay-to Name")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Address"; Rec."Pay-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Address 2"; Rec."Pay-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Address 3"; Rec."AVF_Pay-to Address 3")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to Post Code"; Rec."Pay-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Pay-to City"; Rec."Pay-to City")
                {
                    ApplicationArea = All;
                }
                field("Pay-to County"; Rec."Pay-to County")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Country/Region Code"; Rec."Pay-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Pay-to County/Country Code';
                }
                field("Pay-to Contact"; Rec."Pay-to Contact")
                {
                    ApplicationArea = All;
                    Importance = Additional;
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
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("On Hold"; Rec."On Hold")
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
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to Address 3"; Rec."AVF_Ship-to Address 3")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to County/Country Code';
                }
                field("Ship-to Contact"; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

                    trigger OnAssistEdit();
                    begin
                        CLEAR(ChangeExchangeRate);
                        if Rec."Posting Date" <> 0D then
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date")
                        else
                            ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate());
                        if ChangeExchangeRate.RunModal() = Action::OK then begin
                            Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter());
                            CurrPage.Update();
                        end;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate();
                    begin
                        CurrPage.Update();
                        PurchCalcDiscByType.ApplyDefaultInvoiceDiscount(0, Rec);
                    end;
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
                field("Entry Point"; Rec."Entry Point")
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
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Importance = Promoted;

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
                    Importance = Promoted;
                }
                field("Prepmt. Payment Discount %"; Rec."Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; Rec."Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Cr. Memo No."; Rec."Vendor Cr. Memo No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control23; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part(Control1903326807; "Item Replenishment FactBox")
            {
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "No." = FIELD("No.");
                Visible = false;
            }
            part(Control1906354007; "Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
            }
            part(Control1901138007; "Vendor Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = true;
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = All;
                ShowFilter = false;
                Visible = false;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control3; "Purchase Line FactBox")
            {
                ApplicationArea = All;
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No.");
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
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
            //AVBCLSVIP 21.3.0.0 19/04/2023 Add : Document Attachment Factbox
            part("Attached Documents"; "Doc. Attachment List Factbox") //C-AVNMTBCVIP.27.1 20/11/25 Fix Code for BC27
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(38),
                              "No." = FIELD("No."),
                              "Document Type" = FIELD("Document Type");
            }
            //C-AVBCLSVIP 21.3.0.0 19/04/2023 Add : Document Attachment Factbox
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Dimensions)
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData Dimension = R;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
#if not CLEAN26
                //AVNMTBCVIP.27.1 19/11/2025 Update Source for BC.27
                // action(Statistics)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Statistics';
                //     Image = Statistics;
                //     ShortCutKey = 'F7';

                //     trigger OnAction();
                //     begin
                //         Rec.OpenPurchaseOrderStatistics();
                //         PurchCalcDiscByType.ResetRecalculateInvoiceDisc(Rec);
                //     end;
                // }
#endif
                action(PurchaseOrderStatistics)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Enabled = Rec."No." <> '';
                    Image = Statistics;
                    ShortCutKey = 'F7';
#if CLEAN26
                    Visible = true;
#else
                    Visible = false;
#endif                    
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                    RunObject = Page "Purchase Order Statistics";
                    RunPageOnRec = true;
                }
                //C-AVNMTBCVIP.27.1 19/11/2025 Update Source for BC.27
                action(Card)
                {
                    ApplicationArea = All;
                    Caption = 'Card';
                    Image = EditLines;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
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
                        //For BC15--BC18
                        //ApprovalEntries.Setfilters(Database::"Purchase Header", Rec."Document Type".AsInteger(), Rec."No.");
                        //For BC19
                        ApprovalEntries.SetRecordFilters(Database::"Purchase Header", Rec."Document Type", Rec."No.");
                        ApprovalEntries.Run();
                    end;
                }
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = field("Document Type"),
                                  "No." = field("No."),
                                  "Document Line No." = const(0);
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                Image = Documents;
                action(Receipts)
                {
                    ApplicationArea = All;
                    Caption = 'Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = field("No.");
                    RunPageView = sorting("Order No.");
                }
                action(Invoices)
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    Image = Invoice;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
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
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                separator(Separator181)
                {
                }
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
                separator(Separator182)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action("Get &Sales Order")
                    {
                        ApplicationArea = All;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action228)
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            //how to fix
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Separator82)
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
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId());
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId());
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId());
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = const(38),
                                  "Document Type" = field("Document Type"),
                                  "Document No." = field("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group(ActionGroup13)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Separator73)
                {
                }
                action(Release)
                {
                    ApplicationArea = All;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = All;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Separator611)
                {
                }
                group(ActionGroup225)
                {
                    Caption = 'Dr&op Shipment';
                    Image = Delivery;
                    action(Action184)
                    {
                        ApplicationArea = All;
                        Caption = 'Get &Sales Order';
                        Image = "Order";
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                    }
                }
                group(ActionGroup186)
                {
                    Caption = 'Speci&al Order';
                    Image = SpecialOrder;
                    action(Action187)
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData "Sales Shipment Header" = R;
                        Caption = 'Get &Sales Order';
                        Image = "Order";

                        trigger OnAction();
                        var
                            PurchHeader: Record "Purchase Header";
                            DistIntegration: Codeunit "Dist. Integration";
                        begin
                            //how to fix
                            PurchHeader.Copy(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                action("Archive Document")
                {
                    ApplicationArea = All;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Send IC Purchase Order")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Purchase Order';
                    Image = IntercompanyOrder;

                    trigger OnAction();
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                            ICInOutboxMgt.SendPurchDoc(Rec, false);
                    end;
                }
                separator(Separator189)
                {
                }
                group(IncomingDocument)
                {
                    Caption = 'Incoming Document';
                    Image = Documents;
                    action(IncomingDocCard)
                    {
                        ApplicationArea = All;
                        Caption = 'View Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = ViewOrder;
                        ToolTip = 'View Incoming Document';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            IncomingDocument.ShowCardFromEntryNo(Rec."Incoming Document Entry No.");
                        end;
                    }
                    action(SelectIncomingDoc)
                    {
                        ApplicationArea = All;
                        AccessByPermission = TableData "Incoming Document" = R;
                        Caption = 'Select Incoming Document';
                        Image = SelectLineToApply;
                        ToolTip = 'Select Incoming Document';

                        trigger OnAction();
                        var
                            IncomingDocument: Record "Incoming Document";
                        begin
                            Rec.Validate("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(Rec."Incoming Document Entry No.", Rec.RecordId()));
                        end;
                    }
                    action(IncomingDocAttachFile)
                    {
                        ApplicationArea = All;
                        Caption = 'Create Incoming Document from File';
                        Ellipsis = true;
                        Enabled = NOT HasIncomingDocument;
                        Image = Attach;
                        ToolTip = 'Create Incoming Document from File';

                        trigger OnAction();
                        var
                            IncomingDocumentAttachment: Record "Incoming Document Attachment";
                        begin
                            IncomingDocumentAttachment.NewAttachmentFromPurchaseDocument(Rec);
                        end;
                    }
                    action(RemoveIncomingDoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Remove Incoming Document';
                        Enabled = HasIncomingDocument;
                        Image = RemoveLine;
                        ToolTip = 'Remove Incoming Document';

                        trigger OnAction();
                        begin
                            Rec."Incoming Document Entry No." := 0;
                        end;
                    }
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(ActionGroup17)
            {
                Caption = 'Warehouse';
                Image = Warehouse;
                action("Create &Whse. Receipt")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Warehouse Receipt Header" = R;
                    Caption = 'Create &Whse. Receipt';
                    Image = NewReceipt;

                    trigger OnAction();
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);

                        if not Rec.Find('=><') then
                            Rec.Init();
                    end;
                }
                action("Create Inventor&y Put-away/Pick")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Posted Invt. Put-away Header" = R;
                    Caption = 'Create Inventor&y Put-away/Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;

                    trigger OnAction();
                    begin
                        Rec.CreateInvtPutAwayPick();

                        if not Rec.Find('=><') then
                            Rec.Init();
                    end;
                }
                separator(Separator74)
                {
                }
                /* action(Action99)
                {
                    ApplicationArea = All;
                    Caption = 'Edit Qty to Receive';
                    Image = EditAdjustments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page Page50071;
                    RunPageLink = Field3=FIELD("No."),
                                  Field1=FIELD("Document Type");
                } */
                separator(Separator98)
                {
                }
                /*  action("CANCEL PO")
                 {
                     ApplicationArea = All;
                     Caption = '*** CANCEL PO ***';
                     Image = Cancel;
                     Promoted = true;
                     PromotedCategory = Process;

                     trigger OnAction();
                     begin
                         //AVTSTSTD.003 01/07/2012
                         //Add code for call function Cancel PO on trigger <Control1000000001> - OnPush()
                         AVPR_Function."CANCEL PO"(Rec);
                         //End - AVTSTSTD.003 01/07/2012
                     end;
                 } */
                /* action("FINAL PO")
                {
                    ApplicationArea = All;
                    Caption = '*** FINAL PO ***';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        //AVTSTSTD.004 01/07/2012
                        //Add code for call function FINAL PO on trigger <Control1000000002> - OnPush()
                        AVPR_Function."FINAL PO"(Rec);
                        //End - AVTSTSTD.004 01/07/2012
                    end;
                } */
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                /* action(action79)
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    begin
                        //AVTSTSTD.005 01/07/2012
                        //Add code for check Status to Release on trigger <Control79> - OnPush()
                        TESTFIELD(Status, Status::Released);
                        //End - AVTSTSTD.005 01/07/2012

                        Post(CODEUNIT::"Purch.-Post (Yes/No)");
                    end;
                } */
                action("Preview")
                {
                    ApplicationArea = All;
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;

                    trigger OnAction();
                    var
                        PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";
                    begin
                        PurchPostYesNo.Preview(Rec);
                    end;
                }
                /* action("Post and &Print")
                {
                    ApplicationArea = All;
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+F9';

                    trigger OnAction();
                    begin
                        Post(CODEUNIT::"Purch.-Post + Print");
                    end;
                } */
                action("Test Report")
                {
                    ApplicationArea = All;
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("Post &Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", true, true, Rec);
                        CurrPage.Update(false);
                    end;
                }
                action("Remove From Job Queue")
                {
                    ApplicationArea = All;
                    Caption = 'Remove From Job Queue';
                    Image = RemoveLine;
                    Visible = JobQueueVisible;

                    trigger OnAction();
                    begin
                        Rec.CancelBackgroundPosting();
                    end;
                }
                separator(Separator201)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment Test &Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Prepayment Test &Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;

                        trigger OnAction();
                        begin
                            ReportPrint.PrintPurchHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //how to fix
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //how to fix
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtInvoiceYN(Rec, true);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        ApplicationArea = All;
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //how to fix
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, false);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        ApplicationArea = All;
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;

                        trigger OnAction();
                        var
                            ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                            PurchPostYNPrepmt: Codeunit "Purch.-Post Prepmt. (Yes/No)";
                        begin
                            //how to fix
                            if ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) then
                                PurchPostYNPrepmt.PostPrepmtCrMemoYN(Rec, true);
                        end;
                    }
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("U&ndo FINISHED PO")
                {
                    ApplicationArea = All;
                    Caption = 'U&ndo FINISHED PO';
                    Image = ReverseLines;

                    trigger OnAction();
                    begin
                        //AVTSTSTD.002 01/07/2012
                        //Add Code for Undo FINISHED
                        UndoFINISHED();
                        //End - AVTSTSTD.002 01/07/2012
                    end;
                }
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
                        Clear(AVPurchH);
                        CurrPage.SetSelectionFilter(AVPurchH);
                        report.RunModal(report::"Order", true, false, AVPurchH);
                        //C-AVKITSTD02.001

                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

#if not CLEAN26
                //AVNMTBCVIP.27.1 19/11/2025 Update Source for BC.27
                actionref(Statistics_Promoted; PurchaseOrderStatistics) //C-AVNMTBCVIP.27 25/11/25 Update Code for BC27
                {
                    ObsoleteReason = 'The statistics action will be replaced with the PurchaseStatistics action. The new action uses RunObject and does not run the action trigger. Use a page extension to modify the behaviour.';
                    ObsoleteState = Pending;
                    ObsoleteTag = '26.0';
                }
#else
                actionref(PurchaseOrderStatistics_Promoted; PurchaseOrderStatistics)
                {
                }
#endif
                //C-AVNMTBCVIP.27.1 19/11/2025 Update Source for BC.27
                actionref(Release_Promoted; Release)
                {
                }
                actionref("Create Inventor&y Put-away/Pick_Promoted"; "Create Inventor&y Put-away/Pick")
                {
                }
                actionref("U&ndo FINISHED PO_Promoted"; "U&ndo FINISHED PO")
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Category4)
            {
                Caption = 'Approve', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(Approve_Promoted; Approve)
                {
                }
                actionref(Reject_Promoted; Reject)
                {
                }
                actionref(Delegate_Promoted; Delegate)
                {
                }
                actionref(Comment_Promoted; Comment)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Posting', Comment = 'Generated from the PromotedActionCategories property index 5.';
            }
            group(Category_Category7)
            {
                Caption = 'Prepare', Comment = 'Generated from the PromotedActionCategories property index 6.';
            }
            group(Category_Category8)
            {
                Caption = 'Invoice', Comment = 'Generated from the PromotedActionCategories property index 7.';
            }
            group(Category_Category9)
            {
                Caption = 'Request Approval', Comment = 'Generated from the PromotedActionCategories property index 8.';

                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(Rec.RecordId());
    end;

    trigger OnAfterGetRecord();
    begin
        SetControlAppearance();
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SaveRecord();
        exit(Rec.ConfirmDeletion());
    end;

    trigger OnInit();
    begin
        SetExtDocNoMandatoryCondition();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage();
    begin
        SetDocNoVisible();

        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;
    end;

    var
        AVPurchH: Record "Purchase Header";
        AVPurchL: Record "Purchase Line";
        /* CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines"; */
        ReportPrint: Codeunit "Test Report-Print";
        //DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ChangeExchangeRate: Page "Change Exchange Rate";
        // [InDataSet]
        JobQueueVisible: Boolean;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        VendorInvoiceNoMandatory: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
    //PurchQuoteForm: Page "FNGN011_PR Line List";
    /* PartListEdiable: Boolean;
    [InDataSet]
    Auto_EDITABLE: Boolean;
    AVPR_Function: Codeunit "FNGN011_PR Function"; */


    local procedure Post(PostingCodeunitID: Integer);
    begin
        Rec.SendToPosting(PostingCodeunitID);
        if Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" then
            CurrPage.Close();
        CurrPage.Update(false);
    end;

    local procedure ApproveCalcInvDisc();
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc();
    end;

    local procedure BuyfromVendorNoOnAfterValidate();
    begin
        if Rec.GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SetRange("Buy-from Vendor No.");
        CurrPage.Update();
    end;

    local procedure PurchaserCodeOnAfterValidate();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PaytoVendorNoOnAfterValidate();
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.Update();
    end;

    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.Update();
    end;

    local procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.Update();
    end;

    local procedure Prepayment37OnAfterValidate();
    begin
        CurrPage.Update();
    end;

    local procedure SetDocNoVisible();
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.PurchaseDocumentNoIsVisible(DocType::Order, Rec."No.");
    end;

    local procedure SetExtDocNoMandatoryCondition();
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get();
        VendorInvoiceNoMandatory := PurchasesPayablesSetup."Ext. Doc. No. Mandatory"
    end;

    local procedure SetControlAppearance();
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        JobQueueVisible := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
        SetExtDocNoMandatoryCondition();
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId());
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId());
    end;

    local procedure "//*******************AvisionAddOn*******************//"();
    begin
    end;

    procedure UndoFINISHED();
    begin
        if Confirm('Do you want to undo FINISHED PO No. %1 ?', true, Rec."No.") then begin
            Clear(AVPurchL);
            AVPurchL.SetCurrentKey("Document Type", "Document No.");
            AVPurchL.SetRange("Document No.", Rec."No.");
            AVPurchL.SetRange("Document Type", Rec."Document Type");
            if AVPurchL.find('-') then
                repeat
                    AVPurchL."AVTD_Purchase Status" := AVPurchL."AVTD_Purchase Status"::" ";
                    /*
                    AVPurchL.VALIDATE("Qty. to Receive",AVPurchL.Quantity - AVPurchL."Quantity Received");
                    AVPurchL.VALIDATE("Qty. to Invoice",AVPurchL.Quantity - AVPurchL."Quantity Invoiced");
                    */
                    AVPurchL."Qty. to Receive" := AVPurchL.Quantity - AVPurchL."Quantity Received";
                    AVPurchL."Qty. to Receive (Base)" := AVPurchL."Quantity (Base)" - AVPurchL."Qty. Received (Base)";
                    AVPurchL."Qty. to Invoice" := AVPurchL.Quantity - AVPurchL."Quantity Invoiced";
                    AVPurchL."Qty. to Invoice (Base)" := AVPurchL."Quantity (Base)" - AVPurchL."Qty. Invoiced (Base)";
                    AVPurchL."Outstanding Quantity" := AVPurchL.Quantity - AVPurchL."Quantity Received";
                    AVPurchL."Outstanding Qty. (Base)" := AVPurchL."Quantity (Base)" - AVPurchL."Qty. Received (Base)";
                    AVPurchL.InitOutstandingAmount();
                    AVPurchL.Modify();
                until AVPurchL.Next() = 0;
            //FINISHED := FINISHED::" ";
            Rec.AVTD_FINISHED := false;
            //"Purchase Status" := "Purchase Status"::" ";
            Rec."AVTD_Purchase Status" := Rec."AVTD_Purchase Status"::" ";
            CurrPage.Update();
        end;
    end;
}

