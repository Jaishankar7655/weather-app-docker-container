// background dots
function generatePolkaDots() {
    const dotsContainer = document.createElement("div");
    dotsContainer.classList.add("dots");
    document.body.appendChild(dotsContainer);

    const weatherPalettes = [
        ["#fceabb", "#f8b500", "#ffdd00"], // sunny
        ["#d7d2cc", "#304352", "#a1c4fd"], // cloudy
        ["#2193b0", "#6dd5ed", "#1c92d2"], // rainy
        ["#232526", "#414345", "#f0c27b"], // stormy
        ["#e0eafc", "#cfdef3", "#a1c4fd"], // snowy
    ];

    const numDots = 100;
    const screenW = window.innerWidth;
    const screenH = window.innerHeight;

    for (let i = 0; i < numDots; i++) {
        const dot = document.createElement("div");
        const size = Math.floor(Math.random() * 50) + 15;
        const x = Math.random() * screenW;
        const y = Math.random() * screenH;
        const gradient = weatherPalettes[Math.floor(Math.random() * weatherPalettes.length)];

        dot.style.position = "absolute";
        dot.style.width = `${size}px`;
        dot.style.height = `${size}px`;
        dot.style.borderRadius = "50%";
        dot.style.left = `${x}px`;
        dot.style.top = `${y}px`;
        dot.style.background = `radial-gradient(circle at 30% 30%, ${gradient[0]}, ${gradient[1]}, ${gradient[2]})`;
        dot.style.opacity = "0.8";

        dotsContainer.appendChild(dot);
    }
}

// weather fetcher
async function getWeather() {
    const city = document.getElementById("city").value;
    if (!city) return alert("Enter a city!");

    const response = await fetch(`/weather?city=${city}`);
    const data = await response.json();

    if (data.main) {
        document.getElementById("result").innerHTML = `
      <p><b>${data.name}, ${data.sys.country}</b></p>
      <p>🌡 Temp: ${data.main.temp} °C</p>
      <p>💧 Humidity: ${data.main.humidity}%</p>
      <p>🌬 Wind: ${data.wind.speed} m/s</p>
      <p>⛅ ${data.weather[0].description}</p>
    `;
    } else {
        document.getElementById("result").innerHTML = "<p>❌ City not found</p>";
    }
}

// run dots once page loads
window.onload = generatePolkaDots;
