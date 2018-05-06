// Don't send data to servers when leaving pages
user_pref("beacon.enabled", false);
// Don't send browsing info to Google for malware checking
user_pref("browser.safebrowsing.malware.enabled", false);
// Don't allow click tracking
user_pref("browser.send_pings", false);
// Disable Google scanning downloaded files
user_pref("browser.safebrowsing.appRepURL", "");
// Don't allow access to battery stats
user_pref("dom.battery.enabled", false);
// Don't allow access to microphone and camera status
user_pref("media.navigator.enabled", false);
// No video stats like framerate are sent
user_pref("media.video_stats.enabled", false);
// Only take cookies from visited site
user_pref("network.cookie.cookieBehavior", 1);
// Spoof HTTP referrer URL
user_pref("network.http.referer.spoofSource", true);
// Don't accept link prefetching directives
user_pref("network.prefetch-next", false);
// Send do not track header
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", 1);
// Resist fingerprinting, courtesy of Tor Uplift
user_pref("privacy.resistFingerprinting", true);
