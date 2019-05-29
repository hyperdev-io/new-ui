export const goToPortalPage = () => ({ type: 'OPEN_PORTAL_PAGE' });
export const goToTokenPage = () => ({ type: 'OPEN_TOKEN_PAGE' });
export const goToAboutPage = () => ({ type: 'OPEN_ABOUT_PAGE' });
export const goToAppsPage = () => ({ type: 'SHOW_APPS_PAGE'});
export const goToNewAppPage = () => ({ type: 'OPEN_NEW_APP_PAGE_REQUEST' });
export const goToInstanceDetailsPage = instanceName => ({ type: 'OpenInstanceDetailPageRequest', name: instanceName });
