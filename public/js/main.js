document.addEventListener("DOMContentLoaded", () => {
  // Check if we're on the current user's page.
  if (document.querySelector(".current-profile#profile-stats")) {
    // Cache fields and create a timeout to delay saving on input.
    const usermetas = document.querySelectorAll(
      ".profile-stat:not(.noteditable) .value"
    );
    let timeout = null;

    // Prepare our hidden form for AJAX submission.
    $("#ajax-update-profile").ajaxForm();

    //  Listeners
    for (let meta of usermetas) {
      meta.contentEditable = "true";
      meta.addEventListener("input", () => {
        // Reset timeout each input so delay fires after last input.
        clearTimeout(timeout);
        // Save the fields to the database after .5s
        timeout = setTimeout(() => {
          document.querySelector(
            "#bruh-firstname"
          ).value = document.querySelector(
            "#user-firstname > .value"
          ).innerText;
          document.querySelector(
            "#bruh-lastname"
          ).value = document.querySelector("#user-lastname > .value").innerText;
          document.querySelector("#bruh-email").value = document.querySelector(
            "#user-email > .value"
          ).innerText;
          document.querySelector(
            "#bruh-nickname"
          ).value = document.querySelector("#user-nickname > .value").innerText;
          document.querySelector(
            "#bruh-hobbies"
          ).value = document.querySelector("#user-hobbies > .value").innerText;
          document.querySelector(
            "#bruh-fontcolor"
          ).value = document.querySelector(
            "#user-fontcolor > .value"
          ).innerText;
          document.querySelector(
            "#bruh-bgcolor"
          ).value = document.querySelector("#user-bgcolor > .value").innerText;

          // POST using jQuery Form Plugin
          $("#ajax-update-profile").ajaxSubmit();
        }, 500);
      });
    } // for: user metas

    // Add Event Listener for New Post Content length.
    const npContent = document.querySelector("#newpost-content");
    const npCount = document.querySelector("#newpost-content-count");
    npContent.addEventListener("input", () => {
      if (npContent.value.length > 150) {
        npContent.value = npContent.value.substring(0, 150);
      }
      npCount.innerText = `${npContent.value.length}/150`;
    });
  } // if: /user route


  if (document.querySelector("#post-controls")) {
    // Cache DOM Elements.
    const editToggle = document.querySelector("#post-update");
    const postTitle = document.querySelector("#post-hero h1");
    const postContent = document.querySelector("#post-content");

    // Prepare our hidden form for AJAX submission.
    $("#ajax-update-post").ajaxForm();

    // Toggle Edit Mode on "Edit Post" button click.
    editToggle.addEventListener("click", () => {
      $("body").toggleClass("editmode");

      // If we're in edit mode:
      if ($(".editmode").length > 0) {
        editToggle.innerText = "Save Post";
        postTitle.contentEditable = "true";
        postContent.contentEditable = "true";
      } else {
        // We just left edit mode.
        editToggle.innerText = "Edit Post";
        postTitle.contentEditable = "false";
        postContent.contentEditable = "false";
        // Send our title/content to the hidden AJAX form and submit.
        document.querySelector("#hup-title").value = postTitle.innerText;
        document.querySelector("#hup-content").value = postContent.innerText;
        $("#ajax-update-post").ajaxSubmit();
      }
    }); // editToggle.click()

    // Limit Post Content t
    postContent.addEventListener("input", () => {
      if (postContent.innerText.length > 150) {
        postContent.innerText = postContent.innerText.substring(0, 150);
      }
    }); // postContent.input()
  } // if: /post route, author: current user
});