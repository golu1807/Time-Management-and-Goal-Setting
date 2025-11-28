<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container mt-5">
        <div class="card p-4 shadow-sm">
            <h3 class="text-center mb-4">User Profile</h3>
            <div class="mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="name" value="John Doe" readonly>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email address</label>
                <input type="email" class="form-control" id="email" value="johndoe@example.com" readonly>
            </div>
            <div class="d-flex justify-content-end">
                <a href="edit-profile.html" class="btn btn-warning">Edit Profile</a>
            </div>
        </div>
    </div>
</body>
</html>
