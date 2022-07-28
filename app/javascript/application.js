// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "jquery-ujs"

window.$ = window.jQuery = jQuery;

console.log($); // ok
stripe.confirmCardPayment(clientSecret).then(function(response) {
    if (response.error) {
        // Handle error here
    } else if (response.paymentIntent && response.paymentIntent.status === 'succeeded') {
        // Handle successful payment here
    }
});