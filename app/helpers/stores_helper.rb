module StoresHelper
  def approve_store_link(store)
    link_to "Approve", edit_store_path(store, approve: "yes") unless store.approved?
  end

  def decline_store_link(store)
    link_to "Decline", edit_store_path(store) unless store.approved?
  end

  def activate_or_deactivate_store_link(store)

  end
end
