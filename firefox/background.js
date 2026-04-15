(function() {
    let browserApi = globalThis.chrome || globalThis.browser;
    let dashboardUrl = browserApi.runtime.getURL('history.html');

    function openDashboard() {
        browserApi.tabs.query({url: dashboardUrl}, function(tabs) {
            if (browserApi.runtime.lastError) {
                browserApi.tabs.create({url: dashboardUrl});
                return;
            }

            if (tabs && tabs.length > 0) {
                let tab = tabs[0];
                browserApi.tabs.update(tab.id, {active: true});
                if (tab.windowId !== undefined) {
                    browserApi.windows.update(tab.windowId, {focused: true});
                }
                return;
            }

            browserApi.tabs.create({url: dashboardUrl});
        });
    }

    browserApi.commands.onCommand.addListener(function(command) {
        if (command === 'open-history-dashboard') {
            openDashboard();
        }
    });
})();
