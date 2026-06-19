page 70046 "AVTD_Inventory Order"
{
    // version AVTHLC1.0,AVTSTNAV.01

    PageType = Card;
    SourceTable = "AVTD_Issue Header";
    SourceTableView = sorting("Issue No.")
                      where(Status = filter(Order));
    Caption = 'Inventory Order';
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
                    Caption = 'Issue No.';
                    Editable = "Issue No.Editable";
                    Style = Standard;
                    StyleExpr = TRUE;
                    AssistEdit = true;

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

                    trigger OnValidate();
                    begin
                        //SalesPersonName := SalesPerson.ShowSalePersonName("Requested By");
                        SalesPersonName := Rec.ShowSalePersonName(Rec."Requested By");
                    end;
                }
                field("SalesPerson_Name"; SalesPersonName)
                {
                    Caption = 'Requested Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                //comment approve by consult
                /* field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Clear(CustomerName);
                        Clear(Cust);
                        if Cust.GET("Customer No.") then
                            CustomerName := Cust.Name;
                    end;
                } */
                field("Customer_Name"; CustomerName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    Editable = REMARKEditable;
                }
                field("Remark 2"; Rec."Remark 2")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = "Document DateEditable";
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = "Posting DateEditable";
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Template Name';
                    Editable = JournalTemplateNameEditable;
                }
                field("Gen. Bus Posting Group"; Rec."Gen. Bus Posting Group")
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
            part(SubForm; "AVTD_Inventory Order Subf")
            {
                Caption = 'Lines';
                ApplicationArea = All;
                Editable = SubformEditable;
                SubPageLink = "Journal Template Name" = field("Journal Template Name"),
                              "Journal Batch Name" = field("Journal Batch Name"),
                              "Document No." = field("Issue No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Explode Function")
            {
                Caption = 'Explode Function';
                Visible = true;
                action("Get Item From BOM")
                {
                    ApplicationArea = All;
                    Caption = 'Get Item From BOM';
                    Image = Item;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    var
                    /*  Selection: Integer;
                     Text000: Label '&This vendor from BOM,&All vendor from BOM'; */
                    begin
                        CurrPage.SubForm.Page.ItemJnlExplodBOM();
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

                    trigger OnAction();
                    begin
                        Rec.ShowDocDim();
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    ApplicationArea = All;
                    Caption = 'P&ost';
                    Image = PostDocument;
                    ShortCutKey = 'F9';

                    trigger OnAction();
                    begin
                        Rec.TestField("Journal Batch Name");
                        Rec.TestField("Posting Date");

                        if Confirm('Do you want to post the Issue?', false) then begin
                            if Rec.Type = Rec.Type::"Item Journal" then begin
                                IssueNo := Rec."Issue No.";

                                Clear(ItemTemplateName);
                                Clear(ItemBatchName);
                                ItemTemplateName := Rec."Journal Template Name";
                                ItemBatchName := Rec."Journal Batch Name";

                                Clear(ItemJournalBatch);
                                if not ItemJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then begin
                                    ItemJournalBatch.Init();
                                    ItemJournalBatch."Journal Template Name" := Rec."Journal Template Name";
                                    ItemJournalBatch.Name := Rec."Journal Batch Name";
                                    ItemJournalBatch."AVTD_Journal Type" := ItemJournalBatch."AVTD_Journal Type"::Issue;
                                    ItemJournalBatch.Insert(true);
                                end;

                                Clear(ItemJnlL);
                                ItemJnlL.SetCurrentKey("Journal Template Name", "Journal Batch Name");
                                ItemJnlL.SetRange("Document No.", Rec."Issue No.");
                                if ItemJnlL.FindFirst() then begin
                                    Codeunit.Run(Codeunit::"Item Jnl.-Post", ItemJnlL);

                                    Clear(ItemJournalBatch);
                                    if ItemJournalBatch.Get(ItemTemplateName, ItemBatchName) then
                                        ItemJournalBatch.Delete(true);

                                    Rec.Status := Rec.Status::Posted;
                                    Rec.Modify();
                                    CurrPage.Update(false);

                                    Clear(IssueH);
                                    if IssueH.Get(IssueNo) then;
                                    Page.Run(Page::"AVTD_Posted Inventory", IssueH);

                                    CurrPage.Close();
                                    CurrPage.Update(false);
                                end;
                            end;

                            if Rec.Status = Rec.Status::Posted then
                                DISABLE()
                            else
                                ENABLE();
                        end;
                    end;
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Visible = true;
                /* action("Stock Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Stock Issue';
                    Image = CalculateInventory;

                    trigger OnAction();
                    begin
                        CurrPage.SETSELECTIONFILTER(IssueHead);
                        REPORT.RUNMODAL(50078, true, false, IssueHead);
                    end;
                } */
                action("Issue_print")
                {
                    ApplicationArea = All;
                    Caption = 'Request Issue Inventory';
                    Image = Print;

                    trigger OnAction();
                    begin
                        //CurrPage.SETSELECTIONFILTER(IssueHead);
                        //REPORT.RUNMODAL(50078, true, false, IssueHead);
                        CurrPage.SetSelectionFilter(IssueHead);
                        Report.RunModal(Report::"AVTD_Req. Issue Inventory", true, false, IssueHead);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref("P&ost_Promoted"; "P&ost")
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Release';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Rec.Status = Rec.Status::Posted then
            DISABLE()
        else
            ENABLE();

        //OnAfterGetCurrRecord;
        IssueTypeOnFormat();
    end;

    trigger OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        //SalesPersonName := SalesPerson.ShowSalePersonName("Requested By");
        SalesPersonName := Rec.ShowSalePersonName(Rec."Requested By");
        //comment approve by consult
        /* Clear(CustomerName);
        Clear(Cust);
        if Cust.GET("Customer No.") then
            CustomerName := Cust.Name; */
    end;

    trigger OnInit();
    begin
        SubformEditable := true;
        RemarkEditable := true;
        "Document DateEditable" := true;
        "Posting DateEditable" := true;
        "Issue No.Editable" := true;
        "Issue TypeEnable" := true;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Rec."User Id" := UserId();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."User Id" := UserId();
        Rec.Type := Rec.Type::"Item Journal";

        if Rec.Status = Rec.Status::Posted then
            DISABLE()
        else
            ENABLE();

        //OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        if Rec.Status = Rec.Status::Posted then
            DISABLE()
        else
            ENABLE();
    end;

    var
        ItemJournalBatch: Record "Item Journal Batch";
        ItemJnlL: Record "Item Journal Line";
        IssueH: Record "AVTD_Issue Header";
        IssueHead: Record "AVTD_Issue Header";
        IssueNo: Code[20];
        SalesPersonName: Text[100];
        CustomerName: Text[100];
        ItemTemplateName: Code[10];
        ItemBatchName: Code[20];
        /* Text001: Label 'Location must not be blank';
                Plant: Text[10];
                ItemJ: Record "Item Journal Line";
                ItemJnlMgt: Codeunit ItemJnlManagement;
                UserMgt: Codeunit "User Setup Management";
                SalesPerson: Record "Salesperson/Purchaser";
                Cust: Record Customer; */
        // [InDataSet]
        "Issue TypeEnable": Boolean;
        // [InDataSet]
        "Issue No.Editable": Boolean;
        // [InDataSet]
        "Posting DateEditable": Boolean;
        // [InDataSet]
        "Document DateEditable": Boolean;
        // [InDataSet]
        JournalTemplateNameEditable: Boolean;
        // [InDataSet]
        RemarkEditable: Boolean;
        // [InDataSet]
        SubformEditable: Boolean;

    procedure DISABLE();
    begin
        "Issue No.Editable" := false;
        "Posting DateEditable" := false;
        "Document DateEditable" := false;
        JournalTemplateNameEditable := false;
        RemarkEditable := false;
        SubformEditable := false;
    end;

    procedure ENABLE();
    begin
        "Issue No.Editable" := true;
        "Posting DateEditable" := true;
        "Document DateEditable" := true;
        RemarkEditable := true;
        SubformEditable := true;
    end;

    /*local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        SalesPersonName := SalesPerson.ShowSalePersonName("Requested By");

        Clear(CustomerName);
        Clear(Cust);
        if Cust.GET("Customer No.") then
          CustomerName := Cust.Name;
    end;*/

    local procedure IssueTypeOnFormat();
    begin
        if Rec.Type = Rec.Type::"Item Journal" then
            "Issue TypeEnable" := true
        else
            "Issue TypeEnable" := false;
    end;
}

