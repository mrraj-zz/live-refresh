jQuery(document).ready(function() {
  setTimeout(function() {
    var source = new EventSource('/monitor_filesystems');
    source.addEventListener('refresh', function(e) {
      window.location.reload();
    });
  }, 1);
});
