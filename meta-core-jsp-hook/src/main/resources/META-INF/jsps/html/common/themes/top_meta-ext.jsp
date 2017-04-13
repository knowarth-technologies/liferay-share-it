<%@page import="com.liferay.portal.kernel.util.Validator"%>
<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.util.ListMergeable"%>

<c:if test="<%= layout != null %>">
	<%
		String currentLanguageId = LanguageUtil.getLanguageId(request);
		Locale defaultLocale = LocaleUtil.getSiteDefault();
		String defaultLanguageId = LocaleUtil.toLanguageId(defaultLocale);
	
		String w3cCurrentLanguageId = LocaleUtil.toW3cLanguageId(currentLanguageId);
		String w3cDefaultLanguageId = LocaleUtil.toW3cLanguageId(defaultLanguageId);
		
		UnicodeProperties layoutTypeSettings = themeDisplay.getLayout().getLayoutType().getTypeSettingsProperties();
	    String enableSharingValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-sharing"));
	    
	    String sharingimageURLValue = StringPool.BLANK;
	    String sharingvideoURLValue = StringPool.BLANK;
	    String enableTwitterValue=    StringPool.BLANK;
	    if(Validator.isNotNull(enableSharingValue) && enableSharingValue.equals("true")){
	    	 enableTwitterValue = GetterUtil.getString(layoutTypeSettings.getProperty("enable-twitter-sharing"));	
	    	 sharingimageURLValue = GetterUtil.getString(layoutTypeSettings.getProperty("sharing-image-url"));
	    	 sharingvideoURLValue = GetterUtil.getString(layoutTypeSettings.getProperty("sharing-video-url"));
	    	 
	    	 //converting youtube video page URL to .swf file URL
	    	 if(Validator.isNotNull(sharingvideoURLValue) && sharingvideoURLValue.contains("youtube")) {
	    		 sharingvideoURLValue = sharingvideoURLValue.replace("/watch?v=", "/v/");
	    	 }
	    }
	%>

	<%
		String metaDescription = layout.getDescription(locale, false);
		String metaTitle = layout.getTitle(locale, false);
		String metaDescriptionLanguageId = w3cCurrentLanguageId;
	
		if (Validator.isNull(metaDescription)) {
			metaDescription = layout.getDescription(defaultLocale);
			metaDescriptionLanguageId = w3cDefaultLanguageId;
		}
		
		if (Validator.isNull(metaTitle)) {
			metaTitle = layout.getTitle(defaultLocale);
			metaDescriptionLanguageId = w3cDefaultLanguageId;
		}
	
		ListMergeable<String> pageDescriptionListMergeable = (ListMergeable<String>)request.getAttribute(WebKeys.PAGE_DESCRIPTION);
	
		if (pageDescriptionListMergeable != null) {
			if (Validator.isNotNull(metaDescription)) {
				StringBundler sb = new StringBundler(4);
	
				sb.append(pageDescriptionListMergeable.mergeToString(StringPool.SPACE));
				sb.append(StringPool.PERIOD);
				sb.append(StringPool.SPACE);
				sb.append(metaDescription);
	
				metaDescription = sb.toString();
			}
			else {
				metaDescription = pageDescriptionListMergeable.mergeToString(StringPool.SPACE);
			}
		}
	%>

	<c:if test="<%= Validator.isNotNull(metaTitle) %>">
		<meta property="og:title" lang="<%= metaDescriptionLanguageId %>" content="<%= HtmlUtil.escape(metaTitle) %>" />
	</c:if>
	
	<c:if test="<%= Validator.isNotNull(metaDescription) %>">
		<meta property="og:description" lang="<%= metaDescriptionLanguageId %>" content="<%= HtmlUtil.escape(metaDescription) %>" />
	</c:if>
	
	<meta property="og:url" content="<%=themeDisplay.getPortalURL() + themeDisplay.getURLCurrent()%>" />
	
	<c:if test="<%= Validator.isNotNull(sharingimageURLValue) %>">
		<meta property="og:image" content="<%=sharingimageURLValue%>" />
		<c:if test='<%= sharingimageURLValue.contains("https") %>'>
	       <meta property="og:image:secure_url" content="<%=sharingimageURLValue%>" />
	    </c:if>
		<meta property="og:image:width" content="250" /> 
    	<meta property="og:image:height" content="250" />
	</c:if>

	<c:if test="<%= Validator.isNull(sharingimageURLValue) && Validator.isNotNull(sharingvideoURLValue)%>">
		<meta property="og:image" content="<%= themeDisplay.getPortalURL() %>/html/common/images/video-play.jpg" />
	</c:if>
	
	<c:if test="<%= Validator.isNotNull(sharingvideoURLValue) %>">
		<meta property="og:video" content="<%=sharingvideoURLValue%>" />
		<c:if test='<%= sharingvideoURLValue.contains("https") %>'>
	    	<meta property="og:video:secure_url" content="<%=sharingvideoURLValue%>" />
	    </c:if>
		<meta property="og:video:width" content="250" />
    	<meta property="og:video:height" content="250" />
	</c:if>
	
	<c:if test="<%= enableTwitterValue.equals(StringPool.TRUE) %>">
		<%
			String twitterCard = themeDisplay.getLayout().getFriendlyURL(themeDisplay.getLocale()).replaceAll("/","");
		%>
		<meta name="twitter:card" content="<%= twitterCard %>"/>
		<meta name="twitter:site" content="<%= themeDisplay.getScopeGroupName() %>"/>
		<meta name="twitter:creator" content="<%= themeDisplay.getUser().getFullName() %>"/>
		<meta name="twitter:title" content="<%= HtmlUtil.escape(metaTitle) %>"/>
		<meta name="twitter:description" content="<%= HtmlUtil.escape(metaDescription) %>"/>
		<meta name="twitter:image" content="<%= sharingimageURLValue %>"/>
	</c:if>
</c:if>