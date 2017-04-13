<%@ include file="../init.jsp" %>

<link rel="stylesheet" type="text/css" href="/o/sharing/css/share-tab.css">

<%
long selPlid = ParamUtil.getLong(renderRequest, "selPlid", LayoutConstants.DEFAULT_PLID);

UnicodeProperties layoutTypeSettings = null;
if (selPlid != LayoutConstants.DEFAULT_PLID) {
	Layout selLayout = LayoutLocalServiceUtil.fetchLayout(selPlid);
	layoutTypeSettings = selLayout.getTypeSettingsProperties();
	String enableSharingValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-sharing"));
	String enableFacebookValue = StringPool.BLANK;
	String enableTwitterValue = StringPool.BLANK;
	String enableLinkedInValue = StringPool.BLANK;
	String enableGoogleValue = StringPool.BLANK;
	String displayStyleValue = "left";
	String enabledServices = StringPool.BLANK;
	String imageURL = StringPool.BLANK;
	String videoURL = StringPool.BLANK;
	String iConColorCode=StringPool.BLANK;
	String iConBackgroundColorCode=StringPool.BLANK;
	
	if (enableSharingValue.equals(StringPool.TRUE)) {
		enableFacebookValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-facebook-sharing"));
		enableGoogleValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-gmail-sharing"));
		enableLinkedInValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-linkedin-sharing"));
		enableTwitterValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-twitter-sharing"));
		displayStyleValue = GetterUtil.getString(layoutTypeSettings.getProperty("display-style"));
		imageURL = GetterUtil.getString(layoutTypeSettings.getProperty("sharing-image-url"));
		videoURL = GetterUtil.getString(layoutTypeSettings.getProperty("sharing-video-url"));
		iConColorCode = GetterUtil.getString(layoutTypeSettings.getProperty("iConColorCode"));
		iConBackgroundColorCode = GetterUtil.getString(layoutTypeSettings.getProperty("iConBackgroundColorCode"));
	}
%>

	<aui:input helpMessage="enable.socail.sharing" label="enable.sharing" name="TypeSettingsProperties--enable-sharing--"
		type="toggle-switch" onClick="showHideFunction();" value="<%=enableSharingValue%>" />
		
	<div id="sharingDiv" style="display: none">
		<div class="row">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="heading_brdbg">
							<th><liferay-ui:message key="social.media" /></th>
							<th><liferay-ui:message key="enable" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><label><liferay-ui:message key="social.media.facebook" /></label></td>
							<td><aui:input label="" helpMessage="enable.facebook" name="TypeSettingsProperties--enable-facebook-sharing--"
									type="toggle-switch" value="<%=enableFacebookValue%>" />
							</td>
						</tr>
						<tr>
							<td>
								<label><liferay-ui:message key="social.media.gmail" /></label>
							</td>
							<td>
								<aui:input label="" helpMessage="enable.gmail" name="TypeSettingsProperties--enable-gmail-sharing--"
									type="toggle-switch" value="<%=enableGoogleValue%>" />
							</td>
						</tr>
						<tr>
							<td>
								<label><liferay-ui:message key="social.media.linkedIn" /></label>
							</td>
							<td>
								<aui:input label="" helpMessage="enable.linkedin" name="TypeSettingsProperties--enable-linkedin-sharing--"
									type="toggle-switch" value="<%=enableLinkedInValue%>" />
							</td>
						</tr>
						<tr>
							<td>
								<label><liferay-ui:message key="social.media.twitter" /></label>
							</td>
							<td>
								<aui:input label="" helpMessage="enable.twitter" name="TypeSettingsProperties--enable-twitter-sharing--"
									type="toggle-switch" value="<%=enableTwitterValue%>" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="heading_brdbg">
							<th><liferay-ui:message key="display.style" /></th>
							<th><liferay-ui:message key="display.settings" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<label><liferay-ui:message key="display.alignment" /></label>
							</td>
							<td>
								<div class="btn-group custom_color" data-toggle="buttons">
									<% if(displayStyleValue.equalsIgnoreCase("left")) { %>
										<label class="btn btn-primary active"> 
									<%} else { %>
										<label class="btn btn-primary">
									<%} %>
									
										<aui:input name="TypeSettingsProperties--display-style--" 
											checked="<%=(displayStyleValue.equalsIgnoreCase("left"))?true:false %>"  
											label="" value="left" type="radio">
											<liferay-ui:message key="display.position.left" />
										</aui:input>
										
										</label> 
										
									<% if(displayStyleValue.equalsIgnoreCase("right")) { %>	
										<label class="btn btn-primary active"> 
									<%} else { %>
										<label class="btn btn-primary">
									<%} %>	
									
										<aui:input name="TypeSettingsProperties--display-style--" 
											checked="<%=(displayStyleValue.equalsIgnoreCase("right"))?true:false %>" 
											label="" value="right" type="radio">
											<liferay-ui:message key="display.position.right" />
										</aui:input>
										</label>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<label><liferay-ui:message key="display.icon.color" /></label>
							</td>
							<td>
								<input class="iConColor btn btn-default" type="text" placeholder="Choose Color" 
									readonly style="background-color: <%=iConColorCode%>">
								<aui:input  cssClass="colorCodeicon" type="hidden" name='TypeSettingsProperties--iConColorCode--' 
									value="<%=iConColorCode%>"></aui:input>
							</td>
						</tr>
						<tr>
							<td>
								<label><liferay-ui:message key="display.icon.bgcolor" /></label>
							</td>
							<td> 
								<input class="iConBackgroundColor btn btn-default" type="text" placeholder="Choose Color" 
									readonly style="background-color: <%=iConBackgroundColorCode%>">
								<aui:input cssClass="colorCodebg" type="hidden" name='TypeSettingsProperties--iConBackgroundColorCode--' 
									value="<%=iConBackgroundColorCode%>"></aui:input>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<br />
		
		<div class="row">
			<div class="col-md-12">
				<label>
					<liferay-ui:message key="media.preview">
					</liferay-ui:message><liferay-ui:icon-help message="media.perivew.help.message"/>
				</label>
			</div>
			<br />
			<div class="col-md-12">
				<aui:input class="language-value field form-control lfr-input-text success-field"
					name="TypeSettingsProperties--sharing-image-url--" type="text"
					maxlength="4000" label="image.url" value="<%=imageURL%>" helpMessage="media.image.perivew.help.message" />
					
				<aui:input class="language-value field form-control lfr-input-text success-field"
					name="TypeSettingsProperties--sharing-video-url--" type="text"
					maxlength="4000" label="video.url" value="<%=videoURL%>" helpMessage="media.video.perivew.help.message" />
			</div>
		</div>
	</div>

<% if (enableSharingValue.equals("true")) { %>
		<aui:script>
			showHideFunction();
		</aui:script>
<%
    }
}
%>

<script>
function showHideFunction() {
	$("#sharingDiv").toggle();
}

	AUI().use('aui-color-picker-popover', function(A) {
		var colorPicker = new A.ColorPickerPopover({
			trigger : '.iConColor',
			zIndex : 10
		}).render();

		colorPicker.on('select', function(event) {
			event.trigger.setStyle('backgroundColor', event.color);
			A.one('.colorCodeicon').val(event.color);
		});

		var colorPicker1 = new A.ColorPickerPopover({
			trigger : '.iConBackgroundColor',
			zIndex : 10
		}).render();

		colorPicker1.on('select', function(event) {
			event.trigger.setStyle('backgroundColor', event.color);
			A.one('.colorCodebg').val(event.color);
		});
	});
</script>
