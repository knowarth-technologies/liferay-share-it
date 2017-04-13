package ka.sharing;

import java.util.Locale;

import org.osgi.service.component.annotations.Component;

import com.liferay.portal.kernel.language.LanguageUtil;
import com.liferay.portal.kernel.servlet.taglib.ui.FormNavigatorCategory;
import com.liferay.portal.kernel.servlet.taglib.ui.FormNavigatorConstants;

@Component(
	immediate = true,
	property = {"service.ranking:Integer=10"},
	service = FormNavigatorCategory.class
)
public class SocialSharingFormNavigatorCategory 
		implements FormNavigatorCategory {

	@Override
	public String getFormNavigatorId() {
		return FormNavigatorConstants.FORM_NAVIGATOR_ID_LAYOUT;
	}

	@Override
	public String getKey() {
		return SocialSharingWebKeys.SHARE_TAB;
	}

	@Override
	public String getLabel(Locale locale) {
		return LanguageUtil.get(locale, SocialSharingWebKeys.SHARE_TAB);
	}
}