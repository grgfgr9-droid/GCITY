document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("menuContainer").style.display = "none";

    document.getElementById("closeMenu").addEventListener("click", function() {
        closeMenu();
    });

});


window.addEventListener("message", function(event) {
    if (event.data.action === "openMenu") {
        openMenu(event.data.items, event.data.ingredients);
    }
});

function openMenu(items) {
    const menuContainer = document.getElementById("menuContainer");
    const itemsContainer = document.getElementById("itemsContainer");
    const background = document.getElementById("background");

    // Affichage du menu
    menuContainer.style.display = "block";
    itemsContainer.innerHTML = "";
    background.innerHTML = ""; // Effacer le contenu du background si nécessaire

    // Ajouter le titre dans le background
    const title = document.createElement("h1");
    title.classList.add("background-title");
    title.innerText = "GESTION ARME";
    background.appendChild(title);

    // Ajouter les items avec animation
    items.forEach((item, index) => {
        const itemDiv = document.createElement("div");
        itemDiv.classList.add("carrer");

        const itemIngredients = `
            <div class="ingredients-container">
                ${item.ingredients.map(ingredient => `
                    <div class="img-ingred">
                        <img class="ingred1" src="${ingredient.pics}" alt="${ingredient.label}">
                        <div class="nameingred1">${ingredient.label} (x${ingredient.quantity})</div>
                    </div>
                `).join("")}
            </div>
        `;

        itemDiv.innerHTML = `
            <img class="revo" src="${item.pics}" alt="${item.label}">
            <div class="barre"></div>
            <div class="ingredient">Ingrédients</div>
            ${itemIngredients}
            <button class="perso" onclick="craftItem('${item.name}')">Fabriquer</button>
            <div class="titre">${item.label}</div>
        `;

        itemsContainer.appendChild(itemDiv);

        // Animation de spawn des armes (fade-in + slide-up)
        itemDiv.style.opacity = "0";
        itemDiv.style.transform = "translateY(15px)";

        setTimeout(() => {
            itemDiv.style.transition = "opacity 0.3s ease-out, transform 0.3s ease-out";
            itemDiv.style.opacity = "1";
            itemDiv.style.transform = "translateY(0)";
        }, 100 * index); // Décalage progressif
    });
}





function closeMenu() {
    document.getElementById("menuContainer").style.display = "none";
    fetch("https://ZiZou/closeMenu", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({})
    });
}

function craftItem(itemName) {
    fetch("https://ZiZou/modelPerso", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name: itemName })
    });
    closeMenu();
}