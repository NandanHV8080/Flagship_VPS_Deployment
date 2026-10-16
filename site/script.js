(async function () {
  var el = document.getElementById("status");
  if (!el) return;

  function formatUptime(seconds) {
    var d = Math.floor(seconds / 86400);
    var h = Math.floor((seconds % 86400) / 3600);
    var m = Math.floor((seconds % 3600) / 60);
    if (d > 0) return d + "d " + h + "h";
    if (h > 0) return h + "h " + m + "m";
    return m + "m";
  }

  try {
    var res = await fetch("/api/health", { cache: "no-store" });
    if (!res.ok) throw new Error("bad status");
    var data = await res.json();
    el.textContent = "API online · up " + formatUptime(data.uptime_s);
    el.className = "status ok";
  } catch (err) {
    el.textContent = "API offline";
    el.className = "status down";
  }
})();
