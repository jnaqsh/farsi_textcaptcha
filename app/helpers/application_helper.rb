module ApplicationHelper
  def default_meta_tags
    {
      site: I18n.t('helpers.application.default_meta_tags.site_name'),
    }
  end
end
