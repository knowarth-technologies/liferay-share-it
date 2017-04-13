<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@page import="com.liferay.portal.kernel.util.UnicodeProperties"%>
<%@page import="com.liferay.portal.kernel.theme.ThemeDisplay"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>

<liferay-theme:defineObjects/>

<%
   ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
   UnicodeProperties layoutTypeSettings = themeDisplay.getLayout().getLayoutType().getTypeSettingsProperties();
   String enableSharingValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-sharing"));
   String enableFacebookValue = StringPool.BLANK;
   String enableTwitterValue=StringPool.BLANK;
   String enableLinkedInValue=StringPool.BLANK;
   String enableGoogleValue=StringPool.BLANK;
   String displayStyleValue=StringPool.BLANK;
   String enabledServices=StringPool.BLANK;
   String iConColorCode=StringPool.BLANK;
   String iConBackgroundColorCode=StringPool.BLANK;
   StringBuilder services=new StringBuilder();
   
   if(enableSharingValue.equals(StringPool.TRUE)){
	  
	   enableFacebookValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-facebook-sharing"));
	   enableGoogleValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-gmail-sharing"));
	   enableLinkedInValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-linkedin-sharing"));
	   enableTwitterValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-twitter-sharing"));
	   displayStyleValue = GetterUtil.getString(layoutTypeSettings.getProperty("display-style"));
	   iConColorCode = GetterUtil.getString(layoutTypeSettings.getProperty("iConColorCode"));
	   iConBackgroundColorCode = GetterUtil.getString(layoutTypeSettings.getProperty("iConBackgroundColorCode"));
	 
	   if(enableFacebookValue.equals(StringPool.TRUE)){
		   services.append("facebook,");
	   }
	   if(enableGoogleValue.equals(StringPool.TRUE)){
		   services.append("gmail,");
	   }
	   if(enableTwitterValue.equals(StringPool.TRUE)){
		   services.append("twitter,");
	   }
	   if(enableLinkedInValue.equals(StringPool.TRUE)){
		   services.append("linkedin,");
	   }
	   if(services.length() > 0) {
		   enabledServices=services.substring(0,services.length()-1);   
	   }
   }
%>

<script data-senna-track="temporary" type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js" ></script>

<script type="text/javascript">
	//this will be called once all Smart Layers have been rendered
	var callback = function(smartlayer) {
	    $('.lfr-nav-item').click(function() {
	    	// remove all layers currently on the page
	        smartlayer.destroy();
	
	        // now render Next Layers
	        addthis.layers({
	    	    'whatsnext' : {
	    	        'position' : '<%=displayStyleValue%>',
	    	        'services' : '<%=enabledServices%>',
	    	        'numPreferredServices' : 3,
	    	        'postShareTitle' : 'Thanks for sharing!',
	    	        'desktop' : true,
	    	        'mobile' : false,
	    	        <% if(Validator.isNotNull(iConColorCode)) { %>
	    	        	'iconColor': '<%= iConColorCode %>',
	    	        <% }
	    	        if(Validator.isNotNull(iConBackgroundColorCode)) { %>
	    	      			'background' : '<%= iConBackgroundColorCode %>',
	    	      	<% } %>
	    	    }
	    	});
	    });
	};
	
   <%if(enableSharingValue.equals("true")){%>
		addthis.layers({
		    'theme' : 'transparent',
		    'domain' : '<%= themeDisplay.getPortalURL() %>',
		    'linkFilter' : function(link, layer) {
		        return link;
		    },	
		    'responsive' : {
		      'maxWidth' : '979px',
		      'minWidth' : '0px'
		    },
		    'share' : {
		        'position' : '<%=displayStyleValue%>',
		        'services' : '<%=enabledServices%>',
		        'numPreferredServices' : 3,
		        'postShareTitle' : 'Thanks for sharing!',
		        'desktop' : true,
		        'mobile' : false,
		        <% if(Validator.isNotNull(iConColorCode)) { %>
		        	'iconColor': '<%= iConColorCode %>',
		        <% }
		        if(Validator.isNotNull(iConBackgroundColorCode)) { %>
		      			'background' : '<%= iConBackgroundColorCode %>',
		      	<% } %>
		    }
		}, callback);
	<%} %>
</script>