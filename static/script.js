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
    const dropArea = document.querySelector('.upload-section');
    if (fileInput && fileName) {
        const updateName = files => {
            if (files.length) {
                fileName.textContent = files[0].name;
            } else {
                fileName.textContent = '';
            }
        };

        fileInput.addEventListener('change', () => {
            updateName(fileInput.files);
        });

        if (dropArea) {
            ['dragenter', 'dragover'].forEach(evt => {
                dropArea.addEventListener(evt, e => {
                    e.preventDefault();
                    dropArea.classList.add('drag-over');
                });
            });

            ['dragleave', 'drop'].forEach(evt => {
                dropArea.addEventListener(evt, e => {
                    e.preventDefault();
                    dropArea.classList.remove('drag-over');
                });
            });

            dropArea.addEventListener('drop', e => {
                if (e.dataTransfer.files.length) {
                    const dt = new DataTransfer();
                    Array.from(e.dataTransfer.files).forEach(f => dt.items.add(f));
                    fileInput.files = dt.files;
                    updateName(dt.files);
                }
            });
        }
    }
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', () => {
            startLoading();
        });
    });
});
