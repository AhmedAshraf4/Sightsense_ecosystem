/*nav bar*/
document.addEventListener("DOMContentLoaded", function () {
	const logoImage = document.getElementById("logoImage");
	const homeText = document.getElementById("homeText");
	const aboutText = document.getElementById("aboutText");
	const pricingText = document.getElementById("pricingText");
	const contactText = document.getElementById("contactText");
	const newsText = document.getElementById("newsText");
	const cartIcon = document.getElementById("cartIcon");
	const searchIcon = document.getElementById("searchIcon");

	if (logoImage) {
		logoImage.addEventListener("click", function () {
			window.location.href = "home.html";
		});
	}
	if (homeText) {
		homeText.addEventListener("click", function () {
			window.location.href = "home.html";
		});
	}
	if (aboutText) {
		aboutText.addEventListener("click", function () {
			window.location.href = "about.html";
		});
	}
	if (pricingText) {
		pricingText.addEventListener("click", function () {
			window.location.href = "pricing.html";
		});
	}
	if (contactText) {
		contactText.addEventListener("click", function () {
			window.location.href = "contact.html";
		});
	}
	if (newsText) {
		newsText.addEventListener("click", function () {
			window.location.href = "news.html";
		});
	}
	if (cartIcon) {
		cartIcon.addEventListener("click", function () {
			window.location.href = "cart.html";
		});
	}
	if (searchIcon) {
		searchIcon.addEventListener("click", function () {
			window.location.href = "search.html";
		});
	}
});


/*footer*/
document.addEventListener("DOMContentLoaded", function () {
	const image6Icon = document.getElementById("image6Icon");
	const image9Icon = document.getElementById("image9Icon");
	const image10Icon = document.getElementById("image10Icon");
	const pagesText = document.getElementById("pagesText");
	const pagesText1 = document.getElementById("pagesText1");
	const pagesText2 = document.getElementById("pagesText2");
	const pagesText3 = document.getElementById("pagesText3");
	const pagesText4 = document.getElementById("pagesText4");

	if (image6Icon) {
		image6Icon.addEventListener("click", function () {
			window.open("https://web.facebook.com/?_rdc=1&_rdr");
		});
	}

	if (image9Icon) {
		image9Icon.addEventListener("click", function () {
			window.open("https://www.linkedin.com/");
		});
	}
	if (image10Icon) {
		image10Icon.addEventListener("click", function () {
			window.open("https://www.instagram.com/");
		});
	}
	if (pagesText) {
		pagesText.addEventListener("click", function () {
			window.location.href = "Home.html"
		});
	}
	if (pagesText1) {
		pagesText1.addEventListener("click", function () {
			window.location.href = "pricing.html"
		});
	}
	if (pagesText2) {
		pagesText2.addEventListener("click", function () {
			window.location.href = "contact.html"
		});
	}
	if (pagesText3) {
		pagesText3.addEventListener("click", function () {
			window.location.href = "news.html"
		});
	}
	if (pagesText4) {
		pagesText4.addEventListener("click", function () {
			window.location.href = "about.html"
		});
	}
});


/*Home Buttons */
document.addEventListener("DOMContentLoaded", function () {
	const products1 = document.getElementById("home-our-products");
	const contact1 = document.getElementById("home-contact");
	const basic2cart = document.getElementById("basic2cart");
	const premium2cart = document.getElementById("premium2cart");
	const viewprice1 = document.getElementById("viewprice1");
	const viewprice2 = document.getElementById("viewprice2");
	const ourProductsButton = document.getElementById("ourProductsButton");
	const ourProductsButton2 = document.getElementById("ourProductsButton2");
	const viewnews1 = document.getElementById("viewnews1");
	const viewnews2 = document.getElementById("viewnews2");
	const viewnews3 = document.getElementById("viewnews3");
	if (products1) {
		products1.addEventListener("click", function () {
			window.location.href = "pricing.html"
		});
	}
	if (contact1) {
		contact1.addEventListener("click", function () {
			window.location.href = "contact.html"
		});
	}
	if (basic2cart) {
		basic2cart.addEventListener("click", function () {
			window.location.href = "cart.html"
		});
	}
	if (premium2cart) {
		premium2cart.addEventListener("click", function () {
			window.location.href = "cart.html"
		});
	}

	if (viewprice1) {
		viewprice1.addEventListener("click", function () {
			window.location.href = "pricing.html"
		});
	}
	if (viewprice2) {
		viewprice2.addEventListener("click", function () {
			window.location.href = "pricing.html"
		});
	}
	if (ourProductsButton) {
		ourProductsButton.addEventListener("click", function () {
			window.location.href = "about.html"
		});
	}
	if (ourProductsButton2) {
		ourProductsButton2.addEventListener("click", function () {
			window.location.href = "about.html"
		});
	}
	if (viewnews1) {
		viewnews1.addEventListener("click", function () {
			window.location.href = "news.html"
		});
	}
	if (viewnews2) {
		viewnews2.addEventListener("click", function () {
			window.location.href = "news.html"
		});
	}
	if (viewnews3) {
		viewnews3.addEventListener("click", function () {
			window.location.href = "news.html"
		});
	}

});

/* About Buttons */
document.addEventListener("DOMContentLoaded", function () {
	const closeContainer = document.getElementById("closeContainer");
	const image22 = document.getElementById("image22");
	const image21 = document.getElementById("image21");

	if (closeContainer) {
		closeContainer.addEventListener("click", function () {
			window.history.back();
		});
	}
	if (image22) {
		image22.addEventListener("click", function () {
			window.open("https://www.apple.com/eg/app-store/");
		});
	}
	if (image21) {
		image21.addEventListener("click", function () {
			window.open("https://play.google.com/store/games?pli=1");
		});
	}

});

/*contact us*/
document.addEventListener("DOMContentLoaded", function () {
	const emailText = document.getElementById("email-text");

	if (emailText) {
		emailText.addEventListener("click", function () {
			event.preventDefault();
			const email = this.innerText;
			const subject = encodeURIComponent('Support Inquiry');
			const url = `https://outlook.live.com/owa/?path=/mail/action/compose&to=${email}&subject=${subject}`;
			window.open(url, '_blank');
		});
	}
});

/* Search Page*/
document.addEventListener("DOMContentLoaded", function () {
	const closeContainer = document.getElementById("closeContainer");
	const searchInput = document.getElementById("searchInput");
	const searchButton = document.getElementById("searchButton");
	if (closeContainer) {
		closeContainer.addEventListener("click", function () {
			window.history.back();
		});
	}
	if (searchButton) {
		searchButton.addEventListener("click", function () {
			const searchQuery = searchInput.value.trim();
			if (searchQuery != "") { 
				performSearch(searchQuery);
			}
			else{
				alert("Please enter a search input.");
			}
		});
		searchInput.addEventListener("keypress",function(e){
			if(e.key=='Enter'){
				searchButton.click();
			}
		});
	}
});
function performSearch(searchQuery) {
    // Example of AJAX request using fetch API
    fetch(`/search-results-api?q=${encodeURIComponent(searchQuery)}`)
        .then(response => response.json())
        .then(data => {
            // Assuming data is returned as JSON with search results
            displaySearchResults(data);
        })
        .catch(error => {
            console.error('Error fetching search results:', error);
            // Handle error case (optional)
            alert('Failed to fetch search results. Please try again later.');
        });
}

function displaySearchResults(results) {
    // Example: Update DOM to display search results dynamically
    console.log('Search results:', results);
    // Implement your logic to update the UI with the search results
    // For example, manipulate DOM elements to display results
    // Here you can render the results directly on the current page without redirection
}
