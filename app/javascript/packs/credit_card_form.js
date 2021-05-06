$(document).on('ready turbolinks:load', function() {
//$(document).ready(function() {
  let show_error, stripeResponseHandler, submitHandler;
  
  submitHandler = function(event) {
    let $form = $(event.target);
    $form.find("input[type=submit]").prop("disabled", true);
    // If Stripe was initialized correctly this will create a token using the credit card info
    if(Stripe) {
      Stripe.card.createToken($form, stripeResponseHandler);
    } else {
      show_error("Failed to load credit card processing functionality. Please reload this page in your browser.");
    }
    return false;
  };

  $(".cc_form").on('submit', submitHandler);

  stripeResponseHandler = function(status, response) {
    let token, $form;

    $form = $('.cc_form');

    if (response.error) {
      console.log(response.error.message);
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvc]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $("[data-stripe=label]").remove();
      $form.get(0).submit();
    }
    return false;
  };

  show_error = function(message) {
    const auxiliar = $("#flash-messages")
    if (auxiliar.length == 0) {
      $('div.container').prepend("<div id='flash-messages'></div>");
    }
    const alertElement = '<div class="alert alert-warning alert-dismissible fade show" role="alert"><div id="flash_alert">' + message + '</div><button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'
    $("#flash-messages").html(alertElement);
    $('.alert').delay(5000).fadeOut(3000);
    return false;
  };
});
