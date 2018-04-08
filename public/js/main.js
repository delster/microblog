document.addEventListener("DOMContentLoaded", () => {
  // Check if we're on the current user's page.
  if (document.querySelector(".current-profile#profile-stats")) {
    // Cache fields and create a timeout to delay saving on input.
    const usermetas = document.querySelectorAll( '.profile-stat:not(.noteditable) .value' );
    let timeout = null;

    // Prepare our hidden form for AJAX submission.
    $('#ajax-update-profile').ajaxForm();

    // Add Event Listeners for User Metadata Changes.
    for (let meta of usermetas) {
      meta.contentEditable = "true";
      meta.addEventListener( 'input', () => {
        // Reset timeout each input so delay fires after last input.
        clearTimeout(timeout);

        // Save the fields to the database after .5s
        timeout = setTimeout( () => {
          document.querySelector("#huuf-firstname").value = document.querySelector("#user-firstname > .value").innerText;
          document.querySelector("#huuf-lastname").value  = document.querySelector("#user-lastname > .value").innerText;
          document.querySelector("#huuf-email").value     = document.querySelector("#user-email > .value").innerText;
          document.querySelector("#huuf-nickname").value  = document.querySelector("#user-nickname > .value").innerText;
          document.querySelector("#huuf-hobbies").value   = document.querySelector("#user-hobbies > .value").innerText;
          document.querySelector("#huuf-fontcolor").value = document.querySelector("#user-fontcolor > .value").innerText;
          document.querySelector("#huuf-bgcolor").value   = document.querySelector("#user-bgcolor > .value").innerText;

          // POST using jQuery Form Plugin
          $('#ajax-update-profile').ajaxSubmit();

        }, 500);
      });
    } // for: user metas

  }; // if: /user route

});