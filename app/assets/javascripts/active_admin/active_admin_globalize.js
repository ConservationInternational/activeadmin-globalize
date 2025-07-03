document.addEventListener('DOMContentLoaded', function() {
  function translations() {
    // Hides or shows the + button and the remove button.
    function updateLocaleButtonsStatus($dom) {
      const $localeList = $dom.find('.add-locale ul li:not(.hidden)');
      if ($localeList.length === 0) {
        $dom.find('.add-locale').hide();
      } else {
        $dom.find('.add-locale').show();
      }
    }

    // Hides or shows the locale tab and its corresponding element in the add menu.
    function toggleTab($tab, active) {
      const $addButton = $tab.parents('ul').find('.add-locale li:has(a[href="' + $tab.attr('href') + '"])');
      if (active) {
        $tab.addClass('hidden').show().removeClass('hidden');
        $addButton.hide().addClass('hidden');
      } else {
        $tab.addClass('hidden').hide().addClass('hidden');
        $addButton.show().removeClass('hidden');
      }
    }

    document.querySelectorAll('.activeadmin-translations > ul').forEach(function(element) {
      const $dom = $(element);
      // true when tabs are used in show action, false in form
      const showAction = $dom.hasClass('locale-selector');

      if (!$dom.data('ready')) {
        $dom.data('ready', true);

        // Initialize locale selector
        $dom.addClass('locale-selector');

        // Show first tab by default
        const $firstTab = $dom.find('li:first a');
        if ($firstTab.length) {
          $firstTab.click();
        }

        // Handle tab clicks
        $dom.on('click', 'a', function(e) {
          e.preventDefault();
          const $this = $(this);
          const targetLocale = $this.attr('href');

          // Hide all locale content
          $dom.siblings('.locale').hide();
          
          // Show target locale content
          $dom.siblings(targetLocale).show();

          // Update active tab
          $dom.find('li').removeClass('active');
          $this.parent().addClass('active');
        });

        // Handle add locale functionality
        $dom.on('click', '.add-locale a', function(e) {
          e.preventDefault();
          const $this = $(this);
          const targetLocale = $this.attr('href');
          const $tab = $dom.find('a[href="' + targetLocale + '"]').parent();

          toggleTab($tab.find('a'), true);
          updateLocaleButtonsStatus($dom);
          
          // Click the newly added tab
          $tab.find('a').click();
        });

        // Handle remove locale functionality
        $dom.on('click', '.remove-locale', function(e) {
          e.preventDefault();
          const $this = $(this);
          const $localeDiv = $this.closest('.locale');
          const localeClass = $localeDiv.attr('class').match(/locale-([a-z-]+)/);
          
          if (localeClass) {
            const locale = localeClass[1];
            const $tab = $dom.find('a[href=".locale-' + locale + '"]').parent();
            
            // Mark for destruction
            $localeDiv.find('input[name*="[_destroy]"]').val('1');
            $localeDiv.hide();
            
            toggleTab($tab.find('a'), false);
            updateLocaleButtonsStatus($dom);
            
            // Click first visible tab
            const $firstVisibleTab = $dom.find('li:not(.hidden):first a');
            if ($firstVisibleTab.length) {
              $firstVisibleTab.click();
            }
          }
        });

        updateLocaleButtonsStatus($dom);
      }
    });
  }

  translations();
});
