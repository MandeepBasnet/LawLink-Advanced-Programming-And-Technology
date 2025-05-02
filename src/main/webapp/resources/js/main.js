// Profile dropdown functionality
document.addEventListener('DOMContentLoaded', function() {
    const profilePic = document.querySelector('.profile-pic');
    const profileMenu = document.querySelector('.profile-menu');
    
    if (profilePic && profileMenu) {
        profilePic.addEventListener('click', function(e) {
            e.stopPropagation();
            profileMenu.classList.toggle('show');
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', function() {
            if (profileMenu.classList.contains('show')) {
                profileMenu.classList.remove('show');
            }
        });
        
        // Prevent menu from closing when clicking inside it
        profileMenu.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    }
});