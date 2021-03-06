<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmOrder.label', default: 'Order')}"/>
    <title><g:message code="crmOrder.create.title" args="[entityName]"/></title>
    <r:require modules="datepicker,autocomplete"/>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            <crm:datepicker/>

            // Put autocomplete on customer first name.
            $("input[name='customerFirstName']").autocomplete("${createLink(action: 'autocompleteCustomer')}", {
                remoteDataType: 'json',
                extraParams: {a: 'firstName'},
                preventDefaultReturn: true,
                minChars: 1,
                selectFirst: true,
                filterResults: false,
                matchSubset: false,
                useCache: false,
                maxItemsToShow: 20,
                displayValue: function (value, data) {
                    return data[3] || '';
                },
                onItemSelect: function (item) {
                    var data = item.data;
                    $("header h1 small").text(data[2]);
                    $("input[name='customerLastName']").val(data[4]);
                    $("input[name='customerNumber']").val(data[1]);
                    $("input[name='customerRef']").val('crmContact@' + data[0]);
                    $("input[name='customerEmail']").val(data[5]);
                    $("input[name='customerTel']").val(data[6]);
                    $("input[name='invoice.address1']").val(data[7]);
                    $("input[name='invoice.addressee']").val(data[2]);
                    $("input[name='invoice.address2']").val(data[8]);
                    $("input[name='invoice.postalCode']").val(data[10]);
                    $("input[name='invoice.city']").val(data[11]);
                }
            });
            // Put autocomplete on customer last name.
            $("input[name='customerLastName']").autocomplete("${createLink(action: 'autocompleteCustomer')}", {
                remoteDataType: 'json',
                extraParams: {a: 'lastName'},
                preventDefaultReturn: true,
                minChars: 1,
                selectFirst: true,
                filterResults: false,
                matchSubset: false,
                useCache: false,
                maxItemsToShow: 20,
                displayValue: function (value, data) {
                    return data[4] || '';
                },
                onItemSelect: function (item) {
                    var data = item.data;
                    $("header h1 small").text(data[2]);
                    $("input[name='customerFirstName']").val(data[3]);
                    $("input[name='customerNumber']").val(data[1]);
                    $("input[name='customerRef']").val('crmContact@' + data[0]);
                    $("input[name='customerEmail']").val(data[5]);
                    $("input[name='customerTel']").val(data[6]);
                    $("input[name='invoice.addressee']").val(data[2]);
                    $("input[name='invoice.address1']").val(data[7]);
                    $("input[name='invoice.address2']").val(data[8]);
                    $("input[name='invoice.postalCode']").val(data[10]);
                    $("input[name='invoice.city']").val(data[11]);
                }
            });

            // Put autocomplete on delivery name.
            $("input[name='delivery.addressee']").autocomplete("${createLink(action: 'autocompleteCustomer')}", {
                remoteDataType: 'json',
                preventDefaultReturn: true,
                minChars: 1,
                selectFirst: true,
                filterResults: false,
                matchSubset: false,
                useCache: false,
                maxItemsToShow: 20,
                displayValue: function (value, data) {
                    return data[2] || '';
                },
                onItemSelect: function (item) {
                    var data = item.data;
                    $("input[name='deliveryRef']").val('crmContact@' + data[0]);
                    if (data[9]) { /* TODO: THIS IS A HACK FOR ONE SWEDISH CUSTOMER! */
                        $("input[name='delivery.addressee']").val(data[9]);
                    } else {
                        $("input[name='delivery.addressee']").val(data[2]);
                    }
                    $("input[name='delivery.address1']").val(data[7]);
                    $("input[name='delivery.address2']").val(data[8]);
                    $("input[name='delivery.postalCode']").val(data[10]);
                    $("input[name='delivery.city']").val(data[11]);
                    $("input[name='reference3']").val(data[6]); // Phone
                    $("input[name='reference4']").val(data[5]); // Email
                }
            });
        });
    </script>
</head>

<body>

<g:set var="invoiceAddress" value="${crmOrder.invoice}"/>
<g:set var="deliveryAddress" value="${crmOrder.delivery}"/>

<crm:header title="crmOrder.create.title" args="[entityName]"/>

<g:hasErrors bean="${crmOrder}">
    <crm:alert class="alert-error">
        <ul>
            <g:eachError bean="${crmOrder}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </crm:alert>
</g:hasErrors>

<g:form action="create">

<div class="row-fluid">

<div class="span3">
    <div class="row-fluid">

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.number.label"/>
            </label>

            <div class="controls">
                <g:textField name="number" value="${crmOrder.number}" class="span8" autofocus=""/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.orderDate.label"/>
            </label>

            <div class="controls">
                <div class="inline input-append date"
                     data-date="${formatDate(type: 'date', date: crmOrder.orderDate ?: new Date())}">
                    <g:textField name="orderDate" class="span10" size="10"
                                 value="${formatDate(type: 'date', date: crmOrder.orderDate)}"/><span
                        class="add-on"><i
                            class="icon-th"></i></span>
                </div>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.deliveryDate.label"/>
            </label>

            <div class="controls">
                <div class="inline input-append date"
                     data-date="${formatDate(type: 'date', date: crmOrder.deliveryDate ?: new Date())}">
                    <g:textField name="deliveryDate" class="span10" size="10"
                                 value="${formatDate(type: 'date', date: crmOrder.deliveryDate)}"/><span
                        class="add-on"><i
                            class="icon-th"></i></span>
                </div>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.orderStatus.label"/>
            </label>

            <div class="controls">
                <g:select name="orderStatus.id" from="${metadata.orderStatusList}"
                          value="${crmOrder.orderStatus?.id}"
                          optionKey="id" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.orderType.label"/>
            </label>

            <div class="controls">
                <g:select name="orderType.id" from="${metadata.orderTypeList}"
                          value="${crmOrder.orderType?.id}"
                          optionKey="id" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.reference1.label"/>
            </label>

            <div class="controls">
                <g:textField name="reference1" value="${crmOrder.reference1}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.reference2.label"/>
            </label>

            <div class="controls">
                <g:textField name="reference2" value="${crmOrder.reference2}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.campaign.label"/>
            </label>

            <div class="controls">
                <g:textField name="campaign" value="${crmOrder.campaign}" class="span12"/>
            </div>
        </div>
    </div>
</div>

<div class="span3">
    <div class="row-fluid">

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.customerName.label"/>
            </label>

            <div class="controls">
                <g:textField name="customerFirstName" value="${crmOrder.customerFirstName}" class="span5" autocomplete="off"/>
                <g:textField name="customerLastName" value="${crmOrder.customerLastName}" class="span7" autocomplete="off"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.customerCompany.label"/>
            </label>

            <div class="controls">
                <g:textField name="customerCompany" value="${crmOrder.customerCompany}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.invoice.address1.label"/>
            </label>

            <div class="controls">
                <g:textField name="invoice.address1" value="${invoiceAddress?.address1}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.invoice.address2.label"/>
            </label>

            <div class="controls">
                <g:textField name="invoice.address2" value="${invoiceAddress?.address2}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmAddress.postalAddress.label"/>
            </label>

            <div class="controls">
                <g:textField name="invoice.postalCode" value="${invoiceAddress?.postalCode}" class="span4"/>
                <g:textField name="invoice.city" value="${invoiceAddress?.city}" class="span8"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.customerTel.label"/>
            </label>

            <div class="controls">
                <g:textField name="customerTel" value="${crmOrder.customerTel}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.customerEmail.label"/>
            </label>

            <div class="controls">
                <g:textField name="customerEmail" value="${crmOrder.customerEmail}" class="span12"/>
            </div>
        </div>
    </div>
</div>

<div class="span3">
    <div class="row-fluid">

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.deliveryType.label"/>
            </label>

            <div class="controls">
                <g:select name="deliveryType.id" from="${metadata.deliveryTypeList}"
                          value="${crmOrder.deliveryType?.id}"
                          optionKey="id" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.delivery.addressee.label"/>
            </label>

            <div class="controls">
                <g:textField name="delivery.addressee" value="${deliveryAddress?.addressee}"
                             class="span12" autocomplete="off"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.delivery.address1.label"/>
            </label>

            <div class="controls">
                <g:textField name="delivery.address1" value="${deliveryAddress?.address1}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.delivery.address2.label"/>
            </label>

            <div class="controls">
                <g:textField name="delivery.address2" value="${deliveryAddress?.address2}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmAddress.postalAddress.label"/>
            </label>

            <div class="controls">
                <g:textField name="delivery.postalCode" value="${deliveryAddress?.postalCode}" class="span4"/>
                <g:textField name="delivery.city" value="${deliveryAddress?.city}" class="span8"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.reference3.label"/>
            </label>

            <div class="controls">
                <g:textField name="reference3" value="${crmOrder.reference3}" class="span12"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="crmOrder.reference4.label"/>
            </label>

            <div class="controls">
                <g:textField name="reference4" value="${crmOrder.reference4}" class="span12"/>
            </div>
        </div>
    </div>
</div>

<div class="span3">
</div>

</div>


<div class="form-actions">
    <crm:button visual="success" icon="icon-ok icon-white" label="crmOrder.button.save.label"/>
</div>

</g:form>

</body>
</html>
