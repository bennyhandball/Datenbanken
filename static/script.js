// Show a simple loading bar during form submissions
function startLoading() {
    const bar = document.getElementById('loading-container');
    if (bar) {
        bar.style.display = 'block';
    }
}

function stopLoading() {
    const bar = document.getElementById('loading-container');
    if (bar) {
        bar.style.display = 'none';
    }
}

document.addEventListener('DOMContentLoaded', () => {
    stopLoading();
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            startLoading();
        });
    });
});
