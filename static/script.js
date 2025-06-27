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
    const fileInput = document.getElementById('document');
    const fileName = document.getElementById('file-name');
    if (fileInput && fileName) {
        fileInput.addEventListener('change', () => {
            fileName.textContent = fileInput.files.length ? fileInput.files[0].name : '';
        });
    }
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            startLoading();
        });
    });
});
