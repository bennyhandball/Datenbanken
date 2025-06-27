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
    const chat = document.getElementById('chat-container');
    if (chat) {
        chat.scrollTop = chat.scrollHeight;
    }
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            startLoading();
        });
    });
});
