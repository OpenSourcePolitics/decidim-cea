# frozen_string_literal: true

module ProposalsControllerExtends
  def index
    if component_settings.participatory_texts_enabled?
      @proposals = Decidim::Proposals::Proposal
                   .where(component: current_component)
                   .published
                   .not_hidden
                   .only_amendables
                   .includes(:category, :scope, :attachments, :coauthorships)
                   .order(position: :asc)
      render "decidim/proposals/proposals/participatory_texts/participatory_text"
    else
      @base_query = search
                    .results
                    .published
                    .not_hidden

      @proposals = @base_query.includes(:component, :coauthorships, :attachments)
      @all_geocoded_proposals = @base_query.geocoded.where.not(latitude: Float::NAN, longitude: Float::NAN)

      @voted_proposals = if current_user
                           ProposalVote.where(
                             author: current_user,
                             proposal: @proposals.pluck(:id)
                           ).pluck(:decidim_proposal_id)
                         else
                           []
                         end
      @proposals = reorder(@proposals)
      @proposals = paginate(@proposals)
    end
  end
end

Decidim::Proposals::ProposalsController.class_eval do
  prepend(ProposalsControllerExtends)
end
