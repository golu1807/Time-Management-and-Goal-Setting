<!-- Report Content Modal - Include this in pages where reporting is needed -->
<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content bg-dark text-white">
            <div class="modal-header border-danger">
                <h5 class="modal-title" id="reportModalLabel">
                    <i class="bi bi-flag me-2"></i>Report Content
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
            </div>
            <form id="reportForm" action="${pageContext.request.contextPath}/report" method="POST">
                <div class="modal-body">
                    <input type="hidden" name="contentType" id="reportContentType">
                    <input type="hidden" name="contentId" id="reportContentId">

                    <div class="mb-3">
                        <label for="reportReason" class="form-label">Why are you reporting this?</label>
                        <select class="form-select bg-dark text-white border-secondary" id="reportReason" name="reason"
                            required>
                            <option value="">Select a reason...</option>
                            <option value="SPAM">Spam</option>
                            <option value="INAPPROPRIATE">Inappropriate Content</option>
                            <option value="COPYRIGHT">Copyright Violation</option>
                            <option value="HARASSMENT">Harassment</option>
                            <option value="HATE_SPEECH">Hate Speech</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="reportDescription" class="form-label">Additional Details (Optional)</label>
                        <textarea class="form-control bg-dark text-white border-secondary" id="reportDescription"
                            name="description" rows="4"
                            placeholder="Please provide any additional context..."></textarea>
                    </div>

                    <div class="alert alert-info small">
                        <i class="bi bi-info-circle me-2"></i>
                        Your report will be reviewed by our moderation team. False reports may affect your account
                        standing.
                    </div>
                </div>
                <div class="modal-footer border-secondary">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-flag me-2"></i>Submit Report
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Function to open report modal with content details
    function openReportModal(contentType, contentId) {
        document.getElementById('reportContentType').value = contentType;
        document.getElementById('reportContentId').value = contentId;
        document.getElementById('reportForm').reset();
        document.getElementById('reportContentType').value = contentType;
        document.getElementById('reportContentId').value = contentId;

        const modal = new bootstrap.Modal(document.getElementById('reportModal'));
        modal.show();
    }

    // Add confirmation before submitting
    document.getElementById('reportForm')?.addEventListener('submit', function (e) {
        const reason = document.getElementById('reportReason').value;
        if (!reason) {
            e.preventDefault();
            alert('Please select a reason for reporting.');
        }
    });
</script>

<style>
    .modal-content {
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
    }

    .modal-header {
        border-bottom: 1px solid rgba(233, 69, 96, 0.3);
    }

    .modal-footer {
        border-top: 1px solid rgba(255, 255, 255, 0.1);
    }

    .form-select:focus,
    .form-control:focus {
        background: #1a1a2e;
        color: white;
        border-color: #e94560;
        box-shadow: 0 0 10px rgba(233, 69, 96, 0.3);
    }
</style>