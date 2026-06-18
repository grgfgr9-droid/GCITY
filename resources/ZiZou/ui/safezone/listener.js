document.addEventListener("DOMContentLoaded", function () {
    // Création du style CSS dynamiquement
    const style = document.createElement("style");
    style.textContent = `

        #containersz, #containersz2, #containerservice {
            display: none;
            width: 335px;
            height: 55px;
            position: absolute;
            background-color: #1d1d1dd5;
            top: 1%;
            left: 50%;
            transform: translate(-50%,-50%);
            justify-items: center;
            text-align: center;
            border-bottom-left-radius: 5px;
            border-bottom-right-radius: 5px;
        }

        #containersz {
            border-bottom: 3.5px solid #8bff8b;
        }

        #containerservice {
            border-bottom: 3.5px solid rgb(139, 176, 255);
        }

        #containersz2 {
            border-bottom: 3.5px solid #ff5050;
        }

        .small, .small2, .small3 {
            transform: translateY(25px);
            font-size: 25px;
            font-family: Arial, Helvetica, sans-serif;
        }

        .small { 
        color: #8bff8b; 
        }

        .small2 { 
        color: #ff5050; 
        }

        .small3 { 
        color: rgb(139, 176, 255); 
        }

        .white-text { 
        color: white;
        }

        .blue-text { 
        color: rgb(139, 176, 255);
        }

        .green-text {
         color: #8bff8b;
        }

        .red-text { 
        color: #ff5050; 
        }

        .shield-icon {
         margin-right: 5px;
        }

.hammer-icon {
    color: rgb(139, 176, 255) !important;
    margin-right: 5px;
}

    `;
    document.head.appendChild(style);

    const containersz = document.createElement("div");
    containersz.id = "containersz";
    containersz.innerHTML = '<div class="small"><p><i class="fas fa-user-shield shield-icon"></i><span class="white-text">Vous êtes en</span> <span class="green-text"> SafeZone</span></p></div>';
    document.body.appendChild(containersz);

    const containerservice = document.createElement("div");
    containerservice.id = "containerservice";
    containerservice.innerHTML = '<div class="small3"><p><i class="fa-solid fa-hammer hammer-icon"></i><span class="white-text">Vous êtes en</span> <span class="blue-text"> service</span></p></div>';
    document.body.appendChild(containerservice);

    const containersz2 = document.createElement("div");
    containersz2.id = "containersz2";
    containersz2.innerHTML = '<div class="small2"><p><i class="fas fa-user-shield shield-icon"></i><span class="white-text">Vous sortez de</span> <span class="red-text"> SafeZone</span></p></div>';
    document.body.appendChild(containersz2);

    window.addEventListener('message', (event) => {
        var item = event.data;

		if (item !== undefined && item.type === "uisf") {
			if (item.display === true) {
				$("#containersz").stop(true, true).slideDown(500); 
			} else {
				$("#containersz").stop(true, true).slideUp(500);
			}
		}

        if (item !== undefined && item.type === "uiservice") {
			if (item.display === true) {
				$("#containerservice").stop(true, true).slideDown(500); 
			} else {
				$("#containerservice").stop(true, true).slideUp(500);
			}
		}

		if (item !== undefined && item.type === "uisf2") {
			if (item.display === true) {
				$("#containersz2").stop(true, true).slideDown(500);
			} else {
				$("#containersz2").stop(true, true).slideUp(500);
			}
		}
    });
});
