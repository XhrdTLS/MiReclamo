enum Status {
  ERROR,
  RECEIVED,
  UNDER_REVIEW,
  IN_PROGRESS,
  PENDING_INFORMATION,
  RESOLVED,
  CLOSED,
  REJECTED,
  CANCELLED
}

extension StatusExtension on Status {
  String get name {
    switch (this) {
      case Status.ERROR:
        return 'ERROR';
      case Status.RECEIVED:
        return 'RECEIVED';
      case Status.UNDER_REVIEW:
        return 'UNDER_REVIEW';
      case Status.IN_PROGRESS:
        return 'IN_PROGRESS';
      case Status.PENDING_INFORMATION:
        return 'PENDING_INFORMATION';
      case Status.RESOLVED:
        return 'RESOLVED';
      case Status.CLOSED:
        return 'CLOSED';
      case Status.REJECTED:
        return 'REJECTED';
      case Status.CANCELLED:
        return 'CANCELLED';
      default:
        return '';
    }
  }

  static Status fromString(String status) {
    switch (status) {
      case 'ERROR':
        return Status.ERROR;
      case 'RECEIVED':
        return Status.RECEIVED;
      case 'UNDER_REVIEW':
        return Status.UNDER_REVIEW;
      case 'IN_PROGRESS':
        return Status.IN_PROGRESS;
      case 'PENDING_INFORMATION':
        return Status.PENDING_INFORMATION;
      case 'RESOLVED':
        return Status.RESOLVED;
      case 'CLOSED':
        return Status.CLOSED;
      case 'REJECTED':
        return Status.REJECTED;
      case 'CANCELLED':
        return Status.CANCELLED;
      default:
        throw Exception('Invalid status: $status');
    }
  }
}