package ka.sharing;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.liferay.portal.kernel.model.Layout;
import com.liferay.portal.kernel.servlet.taglib.ui.BaseJSPFormNavigatorEntry;
import com.liferay.portal.kernel.servlet.taglib.ui.FormNavigatorConstants;
import com.liferay.portal.kernel.servlet.taglib.ui.FormNavigatorEntry;
import com.liferay.portal.kernel.util.ResourceBundleUtil;

@Component(
	immediate = true,
	property = {"service.ranking:Integer=20"},
	service = FormNavigatorEntry.class
)
public class SocialSharingFormNavigatorEntry extends BaseJSPFormNavigatorEntry<Layout> implements FormNavigatorEntry<Layout> {

	@Override
	public String getCategoryKey() {
		return SocialSharingWebKeys.SHARE_TAB;
	}

	@Override
	public String getFormNavigatorId() {
		return FormNavigatorConstants.FORM_NAVIGATOR_ID_LAYOUT;
	}

	@Override
	protected String getJspPath() {
		return SocialSharingWebKeys.SHARE_JSP_PATH;
	}

	@Override
	public String getKey() {
		return SocialSharingWebKeys.SHARE_JSP;
	}

	@Override
	public String getLabel(Locale locale) {
		ResourceBundle resourceBundle = ResourceBundleUtil.getBundle(
			"content.Language", locale, getClass());

		return resourceBundle.getString(SocialSharingWebKeys.SHARE_JSP);
	}

	@Override
	public void include(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		super.include(request, response);
	}

	@Override
	@Reference(
		target = "(osgi.web.symbolicname=add.sharing.category.layout.portlet)",
		unbind = "-"
	)
	public void setServletContext(ServletContext servletContext) {
		super.setServletContext(servletContext);
	}
}